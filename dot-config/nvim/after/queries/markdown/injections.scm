; extends

(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "cs" "csharp")
  (code_fence_content) @injection.content
  (#set! injection.language "c_sharp"))

(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "typ" "typst")
  (code_fence_content) @injection.content
  (#set! injection.language "typst"))
