{
  description = ''An amateur radio tool to get you a ballpark estimate of where a given Maidenhead grid square is.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-ballpark-v1_0_1.flake = false;
  inputs.src-ballpark-v1_0_1.ref   = "refs/tags/v1.0.1";
  inputs.src-ballpark-v1_0_1.owner = "Mihara";
  inputs.src-ballpark-v1_0_1.repo  = "ballpark";
  inputs.src-ballpark-v1_0_1.type  = "github";
  
  inputs."fsnotify".owner = "nim-nix-pkgs";
  inputs."fsnotify".ref   = "master";
  inputs."fsnotify".repo  = "fsnotify";
  inputs."fsnotify".dir   = "v0_1_4";
  inputs."fsnotify".type  = "github";
  inputs."fsnotify".inputs.nixpkgs.follows = "nixpkgs";
  inputs."fsnotify".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-ballpark-v1_0_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-ballpark-v1_0_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}