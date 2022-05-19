(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Opts.Conda.Uninstall'            *)
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
unit PyPackage.Manager.Defs.Opts.Conda.Uninstall;

interface

uses
  System.Classes,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerDefsOptsCondaUninstall = class(TPyPackageManagerDefsOpts)
  private
    FName: string;
    FPrefix: string;
    FChannel: string;
    FUseLocal: boolean;
    FOverrideChannels: boolean;
    FRepoData: TStrings;
    FAll: boolean;
    FFeatures: boolean;
    FForce: boolean;
    FNoPin: boolean;
    FExperimentalSolver: boolean;
    FUseIndexCache: boolean;
    FInsecure: boolean;
    FOffline: boolean;
    FDryRun: boolean;
    FJson: boolean;
    FQuiet: boolean;
    FVerbose: TStrings;
    FDoNotAskForConfirmation: boolean;
    procedure SetVerbose(const Value: TStrings);
  public
    constructor Create();
    destructor Destroy(); override;
  published
    {***** Target Environment Specification *****}

    /// <summary>
    ///   Name of environment.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    ///   Full path to environment location (i.e. prefix).
    /// </summary>
    property Prefix: string read FPrefix write FPrefix;
    
    {***** Channel Customization *****}
    
    /// <summary>
    ///   Additional channel to search for packages. These are URLs searched in the order
    ///   they are given (including local directories using the 'file://' syntax or 
    ///   simply a path like '/home/conda/mychan' or '../mychan'). Then, the defaults or channels 
    ///   from .condarc are searched (unless --override-channels is given). You can use 'defaults' 
    ///   to get the default packages for conda. You can also use any name and the .condarc 
    ///   channel_alias value will be prepended. The default channel_alias is https://conda.anaconda.org/.
    /// </summary>
    property Channel: string read FChannel write FChannel;
    /// <summary>
    ///   Use locally built packages. Identical to '-c local'.
    /// </summary>
    property UseLocal: boolean read FUseLocal write FUseLocal default false;
    /// <summary>
    ///   Do not search default or .condarc channels. Requires --channel.
    /// </summary>
    property OverrideChannels: boolean read FOverrideChannels write FOverrideChannels default false;
    /// <summary>
    ///   Specify name of repodata on remote server. Conda will try whatever you specify,
    ///   but will ultimately fall back to repodata.json if your specs are not satisfiable with what you specify here. 
    ///   This is used to employ repodata that is reduced in time scope. You may pass this flag more than once. 
    ///   Leftmost entries are tried first, and the fallback to repodata.json is added for you automatically.
    /// </summary>
    property RepoData: TStrings read FRepoData write FRepoData;

    {***** Solver Mode Modifiers *****}
    
    /// <summary>
    ///   Remove all packages, i.e., the entire environment.
    /// </summary>
    property All: boolean read FAll write FAll default false;
    /// <summary>
    ///   Remove features (instead of packages).
    /// </summary>
    property Features: boolean read FFeatures write FFeatures default false;
    /// <summary>
    ///   Forces removal of a package without removing packages that depend on it. Using this option will usually leave your environment in a broken and inconsistent state.
    /// </summary>
    property Force: boolean read FForce write FForce default false;
    /// <summary>
    ///   Ignore pinned file.
    /// </summary>
    property NoPin: boolean read FNoPin write FNoPin default false;
    /// <summary>
    ///   Possible choices: classic, libmamba, libmamba-draft EXPERIMENTAL. Choose which solver backend to use.
    /// </summary>
    property ExperimentalSolver: boolean read FExperimentalSolver write FExperimentalSolver default false; 
       
    {***** Networking Options *****}
    
    /// <summary>
    ///   Use cache of channel index files, even if it has expired.
    /// </summary>
    property UseIndexCache: boolean read FUseIndexCache write FUseIndexCache default false;
    /// <summary>
    ///   Allow conda to perform "insecure" SSL connections and transfers. Equivalent to setting 'ssl_verify' to 'false'.
    /// </summary>
    property Insecure: boolean read FInsecure write FInsecure default false;
    /// <summary>
    ///   Offline mode. Don't connect to the Internet.
    /// </summary>
    property Offline: boolean read FOffline write FOffline default false;
    
    {***** Output, Prompt, and Flow Control Options *****}
    
    /// <summary>
    ///   Only display what would have been done.
    /// </summary>
    property DryRun: boolean read FDryRun write FDryRun default false;
    /// <summary>
    ///   Report all output as json. Suitable for using conda programmatically.
    /// </summary>
    property Json: boolean read FJson write FJson default false;
    /// <summary>
    ///   Do not display progress bar.
    /// </summary>
    property Quiet: boolean read FQuiet write FQuiet default false;
    /// <summary>
    ///   Can be used multiple times. Once for INFO, twice for DEBUG, three times for TRACE.
    /// </summary>
    property Verbose: TStrings read FVerbose write SetVerbose;
    /// <summary>
    ///   Do not ask for confirmation.
    /// </summary>
    property DoNotAskForConfirmation: boolean read FDoNotAskForConfirmation write FDoNotAskForConfirmation default false;    
  end;

implementation

{ TPyPackageManagerDefsUninstallOptsConda }

constructor TPyPackageManagerDefsOptsCondaUninstall.Create;
begin
  FRepoData := TStringList.Create();
  FVerbose := TStringList.Create();
end;

destructor TPyPackageManagerDefsOptsCondaUninstall.Destroy;
begin
  FVerbose.Free();
  FRepoData.Free();
  inherited;
end;

procedure TPyPackageManagerDefsOptsCondaUninstall.SetVerbose(
  const Value: TStrings);
begin
  FVerbose.Assign(Value);
end;

end.
