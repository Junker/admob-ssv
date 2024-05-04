(defpackage admob-ssv
  (:use #:cl)
  (:import-from #:assoc-utils
                #:aget)
  (:export #:verify
           #:*cache-keys-p*
           #:*cached-keys*))
