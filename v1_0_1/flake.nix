{
  description = ''An amateur radio tool to get you a ballpark estimate of where a given Maidenhead grid square is.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-ballpark-v1_0_1.flake = false;
  inputs.src-ballpark-v1_0_1.owner = "Mihara";
  inputs.src-ballpark-v1_0_1.ref   = "refs/tags/v1.0.1";
  inputs.src-ballpark-v1_0_1.repo  = "ballpark";
  inputs.src-ballpark-v1_0_1.type  = "github";
  
  inputs."fsnotify".dir   = "nimpkgs/f/fsnotify";
  inputs."fsnotify".owner = "riinr";
  inputs."fsnotify".ref   = "flake-pinning";
  inputs."fsnotify".repo  = "flake-nimble";
  inputs."fsnotify".type  = "github";
  inputs."fsnotify".inputs.nixpkgs.follows = "nixpkgs";
  inputs."fsnotify".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-ballpark-v1_0_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-ballpark-v1_0_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}