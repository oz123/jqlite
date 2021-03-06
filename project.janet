(declare-project
  :name "jqlite"
  :author "Oz Tiram"
  :license "MIT"
  :url "https://github.com/oz123/jqlite"
  :repo "git+https://github.com/oz123/jqlite.git")

(defn pkg-config [what]
  (def f (file/popen (string "pkg-config " what)))
  (def v (->>
           (file/read f :all)
           (string/trim)
           (string/split " ")))
  (unless (zero? (file/close f))
    (error "pkg-config failed!"))
  v)

(declare-source
  :source ["sqlite.janet"])

(declare-native
  :name "_sqlite"
  :cflags (pkg-config "--keep-system-cflags sqlite3 --cflags")
  :lflags (pkg-config "sqlite3 --libs")
  :source ["sqlite.c"])
