(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Opts.Conda.List'                 *)
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
unit PyPackage.Manager.Defs.Opts.Conda.List;

interface

uses
  System.Classes,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerDefsOptsCondaList = class(TPyPackageManagerDefsOpts)
  private
    FRegex: string;
    FShowChannelUrls: boolean;
    FCanonical: boolean;
    FFullName: boolean;
    FExplicity: boolean;
    FMd5: boolean;
    FExport: boolean;
    FRevisions: boolean;
    FNoPip: boolean;
    FName: string;
    FPrefix: string;
    FJson: boolean;
    FVerbose: TStrings;
    FQuiet: boolean;
    procedure SetVerbose(const Value: TStrings);
  public
    constructor Create();
    destructor Destroy(); override;
  published
    {***** Positional Arguments *****}

    /// <summary>
    ///   List only packages matching this regular expression.
    /// </summary>
    property Regex: string read FRegex write FRegex;

    {***** Named Arguments *****}

    /// <summary>
    ///   Show channel urls. Overrides the value given by conda config --show show_channel_urls.
    /// </summary>
    property ShowChannelUrls: boolean read FShowChannelUrls write FShowChannelUrls default false;
    /// <summary>
    ///   Output canonical names of packages only. Implies --no-pip.
    /// </summary>
    property Canonical: boolean read FCanonical write FCanonical default false;
    /// <summary>
    ///   Only search for full names, i.e., ^<regex>$.
    /// </summary>
    property FullName: boolean read FFullName write FFullName default false;
    /// <summary>
    ///   List explicitly all installed conda packaged with URL (output may be used by conda create --file).
    /// </summary>
    property Explicity: boolean read FExplicity write FExplicity default false;
    /// <summary>
    ///   Add MD5 hashsum when using --explicit
    /// </summary>
    property Md5: boolean read FMd5 write FMd5 default false;
    /// <summary>
    ///   Output requirement string only (output may be used by conda create --file).
    /// </summary>
    property Export: boolean read FExport write FExport default false;
    /// <summary>
    ///   List the revision history and exit.
    /// </summary>
    property Revisions: boolean read FRevisions write FRevisions default false;
    /// <summary>
    ///   Do not include pip-only installed packages.
    /// </summary>
    property NoPip: boolean read FNoPip write FNoPip default false;

    {***** Target Environment Specification *****}

    /// <summary>
    ///   Name of environment.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    ///   Full path to environment location (i.e. prefix).
    /// </summary>
    property Prefix: string read FPrefix write FPrefix;

    {***** Output, Prompt, and Flow Control Options *****}

    /// <summary>
    ///   Report all output as json. Suitable for using conda programmati-cally.
    /// </summary>
    property Json: boolean read FJson write FJson default false;
    /// <summary>
    ///   Use once for info, twice for debug, three times for trace.
    /// </summary>
    property Verbose: TStrings read FVerbose write SetVerbose;
    /// <summary>
    ///   Do not display progress bar.
    /// </summary>
    property Quiet: boolean read FQuiet write FQuiet default false;
  end;

implementation

{ TPyPackageManagerDefsListOptsConda }

constructor TPyPackageManagerDefsOptsCondaList.Create;
begin
  inherited;
  FVerbose := TStringList.Create();
end;

destructor TPyPackageManagerDefsOptsCondaList.Destroy;
begin
  FVerbose.Free();
  inherited;
end;

procedure TPyPackageManagerDefsOptsCondaList.SetVerbose(const Value: TStrings);
begin
  FVerbose := Value;
end;

end.
