(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Opts.Conda.Install'              *)
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
unit PyPackage.Manager.Defs.Opts.Conda.Install;

interface

uses
  System.Classes,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerDefsOptsCondaInstall = class(TPyPackageManagerDefsOpts)
  private
    FRevision: string;
    FFiles: TStrings;
    FName: string;
    FPrefix: string;
    FChannel: string;
    FUseLocal: boolean;
    FOverrideChannels: boolean;
    FRepoData: TStrings;
    FStrictChannelPriority: boolean;
    FNoChannelPriority: boolean;
    FNoDeps: boolean;
    FOnlyDeps: boolean;
    FNoPin: boolean;
    FExperimentalSolver: string;
    FForceReinstall: boolean;
    FNoUpdateDeps: boolean;
    FUpdateDeps: boolean;
    FSatisfiedSkipSolve: boolean;
    FUpdateAll: boolean;
    FUpdateSpecs: boolean;
    FCopy: boolean;
    FMkDir: boolean;
    FClobber: boolean;
    FUseIndexCache: boolean;
    FInsecure: boolean;
    FOffLine: boolean;
    FDryRun: boolean;
    FJson: boolean;
    FQuiet: boolean;
    FVerbose: TStrings;
    FDoNotAskForConfirmation: boolean;
    FDownloadOnly: boolean;
    FShowChannelUrls: boolean;
    procedure SetFiles(const Value: TStrings);
    procedure SetVerbose(const Value: TStrings);
    procedure SetRepoData(const Value: TStrings);
  public
    constructor Create();
    destructor Destroy(); override;
  published
    {***** Named Arguments *****}

    /// <summary>
    ///   Revert to the specified REVISION.
    /// </summary>
    property Revision: string read FRevision write FRevision;
    /// <summary>
    ///   Read package versions from the given file.
    ///   Repeated file specifications can be passed (e.g. --file=file1 --file=file2).
    /// </summary>
    property Files: TStrings read FFiles write SetFiles;

    {***** Target Environment Specification *****}

    /// <summary>
    ///   Name of environment.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    ///   Full path to environment prefix.
    /// </summary>
    property Prefix: string read FPrefix write FPrefix;

    {***** Channel Customization *****}

    /// <summary>
    ///   Additional channel to search for packages. These are URLs searched in the order
    ///   they are given (including local directories using the 'file://'
    ///   syntax or simply a path like '/home/conda/mychan' or '../mychan').
    ///   Then, the defaults or channels from .condarc are searched (unless --override-channels is given).
    ///   You can use 'defaults' to get the default packages for conda.
    ///   You can also use any name and the .condarc channel_alias value will be prepended.
    ///   The default channel_alias is https://conda.anaconda.org/.
    /// </summary>
    property Channel: string read FChannel write FChannel;
    /// <summary>
    ///   Use locally built packages.
    /// </summary>
    property UseLocal: boolean read FUseLocal write FUseLocal default false;
    /// <summary>
    ///   Do not search default or .condarc channels. Requires --channel.
    /// </summary>
    property OverrideChannels: boolean read FOverrideChannels write FOverrideChannels default false;
    /// <summary>
    ///   Specify name of repodata on remote server. Conda will try whatever you specify,
    ///   but will ultimately fall back to repodata.json if your specs are not satisfiable
    ///   with what you specify here. This is used to employ repodata that is reduced in time scope.
    ///   You may pass this flag more than once. Leftmost entries are tried first, and the fallback to
    ///   repodata.json is added for you automatically.
    /// </summary>
    property RepoData: TStrings read FRepoData write SetRepoData;

    {***** Solver Mode Modifiers *****}

    /// <summary>
    ///   Channel  priority  takes  precedence over package version.
    ///   Over-rides the value given by `conda config --show channel_priority`.
    /// </summary>
    property StrictChannelPriority: boolean read FStrictChannelPriority write FStrictChannelPriority default false;
    /// <summary>
    ///   Package  version  takes  precedence over channel priority.
    ///   Over-rides the value given by `conda config --show channel_priority`.
    /// </summary>
    property NoChannelPriority: boolean read FNoChannelPriority write FNoChannelPriority default false;
    /// <summary>
    ///   Do not install, update, remove, or change dependencies.
    ///   This WILL lead to broken environments and inconsistent behavior. Use at your own risk.
    /// </summary>
    property NoDeps: boolean read FNoDeps write FNoDeps default false;
    /// <summary>
    ///   Only install dependencies.
    /// </summary>
    property OnlyDeps: boolean read FOnlyDeps write FOnlyDeps default false;
    /// <summary>
    ///   Ignore pinned file.
    /// </summary>
    property NoPin: boolean read FNoPin write FNoPin default false;
    /// <summary>
    ///   Possible choices: classic, libmamba, libmamba-draft
    ///   EXPERIMENTAL. Choose which solver backend to use.
    /// </summary>
    property ExperimentalSolver: string read FExperimentalSolver write FExperimentalSolver;
    /// <summary>
    ///  Ensure that any user-requested package for the current operation is uninstalled and reinstalled, even if that package already exists in the environment.
    /// </summary>
    property ForceReinstall: boolean read FForceReinstall write FForceReinstall default false;
    /// <summary>
    ///   Don't update dependencies. Overrides the value given  by  `conda config --show update_deps`.
    /// </summary>
    property NoUpdateDeps: boolean read FNoUpdateDeps write FNoUpdateDeps default false;
    /// <summary>
    ///   Update  dependencies. Overrides the value given by `conda config --show update_deps`.
    /// </summary>
    property UpdateDeps: boolean read FUpdateDeps write FUpdateDeps default false;
    /// <summary>
    ///   Exit early and do not run the solver if the requested specs are satisfied.
    ///   Also skips aggressive updates as configured by 'aggressive_update_packages'.
    ///   Similar to the default behavior of 'pip install'.
    /// </summary>
    property SatisfiedSkipSolve: boolean read FSatisfiedSkipSolve write FSatisfiedSkipSolve default false;
    /// <summary>
    ///   Update all installed packages in the environment.
    /// </summary>
    property UpdateAll: boolean read FUpdateAll write FUpdateAll default false;
    /// <summary>
    ///   Update based on provided specifications.
    /// </summary>
    property UpdateSpecs: boolean read FUpdateSpecs write FUpdateSpecs default false;

    {***** Package Linking and Install-time Options *****}

    /// <summary>
    ///   Install all packages using copies instead of hard- or soft-link-ing.
    /// </summary>
    property Copy: boolean read FCopy write FCopy default false;
    /// <summary>
    ///   Create the environment directory if necessary.
    /// </summary>
    property MkDir: boolean read FMkDir write FMkDir default false;
    /// <summary>
    ///   Allow  clobbering of overlapping file paths within packages, and suppress related warnings.
    /// </summary>
    property Clobber: boolean read FClobber write FClobber default false;

    {***** Networking Options *****}

    /// <summary>
    ///   Use cache of channel index files, even if it has expired.
    /// </summary>
    property UseIndexCache: boolean read FUseIndexCache write FUseIndexCache default false;
    /// <summary>
    ///   Allow conda to perform "insecure" SSL connections and transfers.
    ///   Equivalent to setting 'ssl_verify' to 'false'.
    /// </summary>
    property Insecure: boolean read FInsecure write FInsecure default false;
    /// <summary>
    ///   Offline mode, don't connect to the Internet.
    /// </summary>
    property OffLine: boolean read FOffLine write FOffLine default false;

    {***** Output, Prompt, and Flow Control Options *****}

    /// <summary>
    ///   Only display what would have been done.
    /// </summary>
    property DryRun: boolean read FDryRun write FDryRun default false;
    /// <summary>
    ///   Report all output as json. Suitable for using conda programmati-cally.
    /// </summary>
    property Json: boolean read FJson write FJson default false;
    /// <summary>
    ///   Do not display progress bar.
    /// </summary>
    property Quiet: boolean read FQuiet write FQuiet default false;
    /// <summary>
    ///   Use once for info, twice for debug, three times for trace.
    /// </summary>
    property Verbose: TStrings read FVerbose write SetVerbose;
    /// <summary>
    ///   Do not ask for confirmation.
    /// </summary>
    property DoNotAskForConfirmation: boolean read FDoNotAskForConfirmation write FDoNotAskForConfirmation default false;
    /// <summary>
    ///   Solve an environment and ensure package caches are populated,
    ///   but exit prior to unlinking and linking packages into the pre-fix.
    /// </summary>
    property DownloadOnly: boolean read FDownloadOnly write FDownloadOnly default false;
    /// <summary>
    ///   Show channel urls. Overrides the value given  by  `conda  config --show show_channel_urls`.
    /// </summary>
    property ShowChannelUrls: boolean read FShowChannelUrls write FShowChannelUrls default false;
  end;

implementation

{ TPyPackageManagerDefsInstallOptsConda }

constructor TPyPackageManagerDefsOptsCondaInstall.Create;
begin
  FFiles := TStringList.Create();
  FRepoData := TStringList.Create();
  FVerbose := TStringList.Create();
end;

destructor TPyPackageManagerDefsOptsCondaInstall.Destroy;
begin
  FVerbose.Free();
  FRepoData.Free();
  FFiles.Free();
  inherited;
end;

procedure TPyPackageManagerDefsOptsCondaInstall.SetFiles(const Value: TStrings);
begin
  FFiles.Assign(Value);
end;

procedure TPyPackageManagerDefsOptsCondaInstall.SetRepoData(
  const Value: TStrings);
begin
  FRepoData.Assign(Value);
end;

procedure TPyPackageManagerDefsOptsCondaInstall.SetVerbose(
  const Value: TStrings);
begin
  FVerbose.Assign(Value);
end;

end.
