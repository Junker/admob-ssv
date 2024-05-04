(in-package #:admob-ssv)

(defvar *public-key-url* "https://www.gstatic.com/admob/reward/verifier-keys.json")
(defvar *cached-keys* nil)
(defvar *cache-keys-p* nil)

(defun fetch-public-keys ()
  (or (and *cache-keys-p* *cached-keys*)
      (setf *cached-keys*
            (getf (jojo:parse (dex:get *public-key-url*))
                  :|keys|))))

(defun parse-public-ec-key (b64key)
  (let* ((der (cl-base64:base64-string-to-usb8-array b64key))
         (der-parsed (asn1:decode der))
         (y (cdr (caddar der-parsed))))
    (ironclad:make-public-key :secp256r1 :y y)))

(defun parse-signature (sig-str)
  (let ((der (asn1:decode (base64:base64-string-to-usb8-array sig-str :uri t))))
    (ironclad:make-signature :secp256r1
                             :r (ironclad:integer-to-octets (cdadar der))
                             :s (ironclad:integer-to-octets (cdr (caddar der))))))

(defun sha256 (data)
  (ironclad:digest-sequence 'ironclad:sha256 data))

(defun verify (url)
  "Request coming as callback from admob must contain the 'signature' and the 'user_id'.
   * For more info https://developers.google.com/admob/android/rewarded-video-ssv"
  (let* ((uri (quri:uri url))
         (params (quri:uri-query-params uri))
         (sign-str (aget params "signature"))
         (key-id (parse-integer (aget params "key_id")))
         (query (quri:uri-query uri))
         (verify-str (subseq query 0 (search "&signature=" query)))
         (key-entry (find key-id (fetch-public-keys)
                          :key (lambda (item)
                                 (getf item :|keyId|))))
         (key-str (getf key-entry :|base64|)))
    (when (not sign-str)
      (error "No signature value exist in the URL param"))
    (when (not key-str)
      (error "key with ID:~D not found" key-id))
    (ironclad:verify-signature (parse-public-ec-key key-str)
                               (sha256 (babel:string-to-octets verify-str))
                               (parse-signature sign-str))))
