(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Opts.Pip.Install'                *)
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
unit PyPackage.Manager.Defs.Opts.Pip.Install;

interface

uses
  System.Classes,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerDefsOptsPipInstall = class(TPyPackageManagerDefsOpts)
  private
    FRequirement: string;
    FConstraint: string;
    FNoDeps: boolean;
    FPre: boolean;
    FEditable: string;
    FTarget: string;
    FPlatform: string;
    FPythonVersion: string;
    FPythonImplementation: string;
    FAbi: string;
    FUser: boolean;
    FRoot: string;
    FPrefix: string;
    FSource: string;
    FUpgrade: boolean;
    FUpgradeStrategy: string;
    FForceReinstall: boolean;
    FIgnoreInstalled: boolean;
    FIgnoreRequiresPython: boolean;
    FNoBuildIsolation: boolean;
    FUsePep517: boolean;
    FInstallOption: TStrings;
    FGlobalOption: TStrings;
    FCompile: boolean;
    FNoWarnScriptLocation: boolean;
    FNoWarnConflicts: boolean;
    FNoBinary: boolean;
    FNoCompile: boolean;
    FVerbose: boolean;
	FReport: String;
    FOnlyBinary: String;
    FPreferBinary: boolean;
    FRequireHashes: boolean;
    FProgressBar: boolean;
    FNoClean: boolean;
    FIndexUrl: string;
    FExtraIndexUrl: string;
    FNoIndex: boolean;
    FFindLinks: string;
    procedure SetGlobalOption(const Value: TStrings);
    procedure SetInstallOption(const Value: TStrings);
  public
    constructor Create();
    destructor Destroy(); override;
  published
    property Requirement: string read FRequirement write FRequirement;
    property Constraint: string read FConstraint write FConstraint;
    property NoDeps: boolean read FNoDeps write FNoDeps default false;
    property Pre: boolean read FPre write FPre default false;
    property Editable: string read FEditable write FEditable;
    property Target: string read FTarget write FTarget;
    property Platform: string read FPlatform write FPlatform;
    property PythonVersion: string read FPythonVersion write FPythonVersion;
    property PythonImplementation: string read FPythonImplementation write FPythonImplementation;
    property Abi: string read FAbi write FAbi;
    property User: boolean read FUser write FUser default false;
    property Root: string read FRoot write FRoot;
    property Prefix: string read FPrefix write FPrefix;
    property Source: string read FSource write FSource;
    property Upgrade: boolean read FUpgrade write FUpgrade default false;
    property UpgradeStrategy: string read FUpgradeStrategy write FUpgradeStrategy;
    property ForceReinstall: boolean read FForceReinstall write FForceReinstall default false;
    property IgnoreInstalled: boolean read FIgnoreInstalled write FIgnoreInstalled default false;
    property IgnoreRequiresPython: boolean read FIgnoreRequiresPython write FIgnoreRequiresPython default false;
    property NoBuildIsolation: boolean read FNoBuildIsolation write FNoBuildIsolation default false;
    property UsePep517: boolean read FUsePep517 write FUsePep517 default false;
    property InstallOption: TStrings read FInstallOption write SetInstallOption;
    property GlobalOption: TStrings read FGlobalOption write SetGlobalOption;
    property Compile: boolean read FCompile write FCompile default false;
    property NoCompile: boolean read FNoCompile write FNoCompile default false;
    property NoWarnScriptLocation: boolean read FNoWarnScriptLocation write FNoWarnScriptLocation default false;
    property NoWarnConflicts: boolean read FNoWarnConflicts write FNoWarnConflicts default false;
    property NoBinary: boolean read FNoBinary write FNoBinary default false;
    property Verbose: boolean read FVerbose write FVerbose default false;
    property OnlyBinary: String read FOnlyBinary write FOnlyBinary;
    property Report: String read FReport write FReport;
    property PreferBinary: boolean read FPreferBinary write FPreferBinary default false;
    property RequireHashes: boolean read FRequireHashes write FRequireHashes default false;
    property ProgressBar: boolean read FProgressBar write FProgressBar default false;
    property NoClean: boolean read FNoClean write FNoClean default false;
    property IndexUrl: string read FIndexUrl write FIndexUrl;
    property ExtraIndexUrl: string read FExtraIndexUrl write FExtraIndexUrl;
    property NoIndex: boolean read FNoIndex write FNoIndex default false;
    property FindLinks: string read FFindLinks write FFindLinks;
  end;

implementation

{ TPyPackageManagerDefsInstallOptsPip }

constructor TPyPackageManagerDefsOptsPipInstall.Create;
begin
  FInstallOption := TStringList.Create();
  FGlobalOption := TStringList.Create();
end;

destructor TPyPackageManagerDefsOptsPipInstall.Destroy;
begin
  FGlobalOption.Free();
  FInstallOption.Free();
  inherited;
end;

procedure TPyPackageManagerDefsOptsPipInstall.SetGlobalOption(
  const Value: TStrings);
begin
  FGlobalOption.Assign(Value);
end;

procedure TPyPackageManagerDefsOptsPipInstall.SetInstallOption(
  const Value: TStrings);
begin
  FInstallOption.Assign(Value);
end;

end.
