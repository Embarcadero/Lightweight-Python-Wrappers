(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Opts.Pip.List'                   *)
(*                                                                        *)
(*                                  Copyright (c) 2021                    *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                   https://github.com/lmbelo/P4D_AI_ML   *)
(**************************************************************************)
(*  Functionality:  PyPackage Defs.Opts layer                             *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)
(* This source code is distributed with no WARRANTY, for no reason or use.*)
(* Everyone is allowed to use and change this code free for his own tasks *)
(* and projects, as long as this header and its copyright text is intact. *)
(* For changed versions of this code, which are public distributed the    *)
(* following additional conditions have to be fullfilled:                 *)
(* 1) The header has to contain a comment on the change and the author of *)
(*    it.                                                                 *)
(* 2) A copy of the changed source has to be sent to the above E-Mail     *)
(*    address or my then valid address, if this is possible to the        *)
(*    author.                                                             *)
(* The second condition has the target to maintain an up to date central  *)
(* version of the component. If this condition is not acceptable for      *)
(* confidential or legal reasons, everyone is free to derive a component  *)
(* or to generate a diff file to my or other original sources.            *)
(**************************************************************************)
unit PyPackage.Manager.Defs.Opts.Pip.List;

interface

uses
  System.Classes,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerDefsOptsPipList = class(TPyPackageManagerDefsOpts)
  private
    FOutdated: boolean;
    FUpToDate: boolean;
    FEditable: boolean;
    FLocal: boolean;
    FUser: boolean;
    FPath: TStrings;
    FPre: boolean;
    FFormat: string;
    FNotRequired: boolean;
    FExcludeEditable: boolean;
    FIncludeEditable: boolean;
    FExclude: string;
    FIndexUrl: string;
    FExtraIndexUrl: string;
    FNoIndex: boolean;
    FFindLinks: string;
    procedure SetPath(const Value: TStrings);
  public
    constructor Create();
    destructor Destroy(); override;
  published
    {***** Options *****}

    /// <summary>
    ///   List outdated packages
    /// </summary>
    property Outdated: boolean read FOutdated write FOutdated default false;
    /// <summary>
    ///   List uptodate packages
    /// </summary>
    property UpToDate: boolean read FUpToDate write FUpToDate default false;
    /// <summary>
    ///   List editable projects.
    /// </summary>
    property Editable: boolean read FEditable write FEditable default false;
    /// <summary>
    ///   If in a virtualenv that has global access, do not list globally-installed packages.
    /// </summary>
    property Local: boolean read FLocal write FLocal default false;
    /// <summary>
    ///   Only output packages installed in user-site.
    /// </summary>
    property User: boolean read FUser write FUser default false;
    /// <summary>
    ///   Restrict to the specified installation path for listing packages (can be used multiple times).
    /// </summary>
    property Path: TStrings read FPath write SetPath;
    /// <summary>
    ///   Include pre-release and development versions. By default, pip only finds stable versions.
    /// </summary>
    property Pre: boolean read FPre write FPre default false;
    /// <summary>
    ///   Select the output format among: columns (default), freeze, or json
    /// </summary>
    property Format: string read FFormat write FFormat;
    /// <summary>
    ///   List packages that are not dependencies of installed packages.
    /// </summary>
    property NotRequired: boolean read FNotRequired write FNotRequired default false;
    /// <summary>
    ///   Exclude editable package from output.
    /// </summary>
    property ExcludeEditable: boolean read FExcludeEditable write FExcludeEditable default false;
    /// <summary>
    ///   Include editable package from output.
    /// </summary>
    property IncludeEditable: boolean read FIncludeEditable write FIncludeEditable default false;
    /// <summary>
    ///   Exclude specified package from the output
    /// </summary>
    property Exclude: string read FExclude write FExclude;
    /// <summary>
    ///   Base URL of the Python Package Index (default https://pypi.org/simple).
    ///   This should point to a repository compliant with PEP 503 (the simple repository API) or
    ///   a local directory laid out in the same format.
    /// </summary>
    property IndexUrl: string read FIndexUrl write FIndexUrl;
    /// <summary>
    ///   Extra URLs of package indexes to use in addition to --index-url. Should follow the same rules as --index-url.
    /// </summary>
    property ExtraIndexUrl: string read FExtraIndexUrl write FExtraIndexUrl;
    /// <summary>
    ///   Ignore package index (only looking at --find-links URLs instead).
    /// </summary>
    property NoIndex: boolean read FNoIndex write FNoIndex default false;
    /// <summary>
    ///   If a URL or path to an html file, then parse for links to archives such as sdist (.tar.gz) or
    ///   wheel (.whl) files. If a local path or file:// URL that’s a directory, then look for archives in
    ///   the directory listing. Links to VCS project URLs are not supported.
    /// </summary>
    property FindLinks: string read FFindLinks write FFindLinks;
  end;

implementation

{ TPyPackageManagerDefsOptsPipList }

constructor TPyPackageManagerDefsOptsPipList.Create;
begin
  inherited Create();
  FPath := TStringList.Create();
end;

destructor TPyPackageManagerDefsOptsPipList.Destroy;
begin
  FPath.Free();
  inherited;
end;

procedure TPyPackageManagerDefsOptsPipList.SetPath(const Value: TStrings);
begin
  FPath.Assign(Value);
end;

end.
