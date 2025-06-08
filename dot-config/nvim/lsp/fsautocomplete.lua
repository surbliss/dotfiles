return {
   cmd = { "fsautocomplete", "--adaptive-lsp-server-enabled" },
   filetypes = { "fsharp" },
   init_options = {
      AutomaticWorkspaceInit = true,
   },
   settings = {
      FSharp = {
         EnableReferenceCodeLens = true,
         ExternalAutocomplete = false,
         InterfaceStubGeneration = true,
         InterfaceStubGenerationMethodBody = 'failwith "Not Implemented"',
         InterfaceStubGenerationObjectIdentifier = "this",
         Linter = true,
         RecordStubGeneration = true,
         RecordStubGenerationBody = 'failwith "Not Implemented"',
         ResolveNamespaces = true,
         SimplifyNameAnalyzer = true,
         UnionCaseStubGeneration = true,
         UnionCaseStubGenerationBody = 'failwith "Not Implemented"',
         UnusedDeclarationsAnalyzer = true,
         UnusedOpensAnalyzer = true,
         UseSdkScripts = true,
         keywordsAutocomplete = true,
      },
   },
}
