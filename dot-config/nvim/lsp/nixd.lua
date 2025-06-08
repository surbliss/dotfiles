return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	nixd = {
		nixpkgs = {
			expr = "import <nixpkgs> { }",
		},
	},
}
