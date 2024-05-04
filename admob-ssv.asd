(defsystem "admob-ssv"
  :version "0.1.0"
  :author "Dmitrii Kosenkov"
  :license "MIT"
  :depends-on ("dexador"
               "jonathan"
               "cl-base64"
               "ironclad"
               "asn1"
               "pem"
               "babel"
               "quri"
               "assoc-utils")
  :description "Google Admob server-side verification system"
  :homepage "https://github.com/Junker/admob-ssv"
  :source-control (:git "https://github.com/Junker/admob-ssv.git")
  :components ((:file "package")
               (:file "admob-ssv")))
