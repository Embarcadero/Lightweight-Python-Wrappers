unit PyPackage.Manager.Cmd;

interface

uses
  PyPackage.Manager.Defs;

type
  TPyPackageManagerCmd = class(TInterfacedObject)
  protected
    Defs: TPyPackageManagerDefs;
  public
    constructor Create(const ADefs: TPyPackageManagerDefs);
  end;

implementation

{ TPyPackageManagerCmd }

constructor TPyPackageManagerCmd.Create(const ADefs: TPyPackageManagerDefs);
begin
  Defs := ADefs;
end;

end.
