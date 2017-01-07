{  Arquivo criado automaticamente Gerador Multicamadas
   (Multitiers Generator VERS�O 0.01)
   Data e Hora: 11/10/2016 - 23:04:17
}

unit Marvin.AulaMulticamada.Controlador.Cliente;

interface

uses
   { borland }
  Classes,
   { marvin }
  uMRVControladorBase,
  uMRVClasses,
  uMRVClassesServidor,
  { interfaces }
  Marvin.AulaMulticamada.Controlador.Intf,
  { exce�oes }
  Marvin.AulaMulticamada.Excecoes.Cliente,
  Marvin.AulaMulticamada.Excecoes.TipoCliente,
   { cadastros }
  Marvin.AulaMulticamada.Cadastro.Cliente,
  Marvin.AulaMulticamada.Cadastro.TipoCliente,
   { classes de dados e listas }
  Marvin.AulaMulticamada.Classes.TipoCliente,
  Marvin.AulaMulticamada.Classes.Cliente;

type
  coMRVControladorCliente = class
  public
    class function Create(ACliente: TMRVCadastroCliente;
      ATipoCliente: TMRVCadastroTipoCliente): IMRVControladorCliente;
  end;

implementation

uses
   { marvin }
  uMRVCadastroBase;

type
  TMRVControladorCliente = class(TMRVControladorBase, IMRVControladorCliente)
  private
      { cadastros }
    FCadastroCliente: TMRVCadastroCliente;
    FCadastroTipoCliente: TMRVCadastroTipoCliente;
    procedure TipoClienteExiste(const ACliente: TMRVCliente);
  protected
    procedure ExistemDependencias(const AItem: TMRVDadosBase); virtual;
    procedure ComplementarDados(const AItem: TMRVDadosBase);
  public
      { recebe os cadastros que ser�o utilizados }
    constructor Create(ACliente: TMRVCadastroCliente; ATipoCliente:
      TMRVCadastroTipoCliente); reintroduce; overload;
    destructor Destroy; override;
      { m�todos do diagrama de casos de uso }
    procedure Inserir(const AItem: TMRVDadosBase); virtual;
    procedure Excluir(const AItem: TMRVDadosBase); virtual;
    procedure Alterar(const AItem: TMRVDadosBase); virtual;
    function ProcurarItem(const ACriterio, AResultado: TMRVDadosBase): Boolean; virtual;
    function ProcurarItens(const ACriterio: TMRVDadosBase; const AListaResultado:
      TMRVListaBase; const ASearchOption: TMRVSearchOption): Boolean; virtual;
    function RecuperarItens(const ACriterio: TMRVDadosBase; const
      AListaResultado: TMRVListaBase; const ASearchOption: TMRVSearchOption): Boolean;
  end;

{ coMRVControladorCliente }

class function coMRVControladorCliente.Create(ACliente: TMRVCadastroCliente;
  ATipoCliente: TMRVCadastroTipoCliente): IMRVControladorCliente;
begin
  Result := TMRVControladorCliente.Create(ACliente, ATipoCliente);
end;

{ TMRVControladorCliente }

constructor TMRVControladorCliente.Create(ACliente: TMRVCadastroCliente;
  ATipoCliente: TMRVCadastroTipoCliente);
begin
  inherited Create;
   { recupera as refer�ncias de todos os cadastros }
  FCadastroCliente := ACliente;
  FCadastroTipoCliente := ATipoCliente;
end;

destructor TMRVControladorCliente.Destroy;
begin
   { aterra todos os cadastros }
  FCadastroCliente := nil;
  FCadastroTipoCliente := nil;
  inherited;
end;

procedure TMRVControladorCliente.Inserir(const AItem: TMRVDadosBase);
var
  LCliente: TMRVCliente;
begin
   { manda o cadastro inserir o objeto principal }
  if AItem is TMRVCliente then
  begin
    { recupera o cliente }
    LCliente := AItem as TMRVCliente;
    { verifica se o tipo de cliente existe }
    Self.TipoClienteExiste(LCliente);
    { Inclui o cliente }
    FCadastroCliente.Inserir(AItem);
  end;
end;

procedure TMRVControladorCliente.Excluir(const AItem: TMRVDadosBase);
var
  LCliente: TMRVCliente;
begin
   { Converte e valida o parametro informado }
  LCliente := AItem as TMRVCliente;
   { Realiza o tratamento das depend�ncias }
  Self.ExistemDependencias(AItem);
   { Exclui o objeto principal }
  FCadastroCliente.Excluir(LCliente);
end;

procedure TMRVControladorCliente.Alterar(const AItem: TMRVDadosBase);
var
  LCliente: TMRVCliente;
begin
   { manda o cadastro inserir o objeto principal }
  if AItem is TMRVCliente then
  begin
    { recupera o cliente }
    LCliente := AItem as TMRVCliente;
    { verifica se o tipo de cliente existe }
    Self.TipoClienteExiste(LCliente);
    { Manda alterar o objeto principal }
    FCadastroCliente.Alterar(AItem);
  end;
end;

function TMRVControladorCliente.ProcurarItem(const ACriterio, AResultado:
  TMRVDadosBase): Boolean;
begin
  Result := FCadastroCliente.ProcurarItem(ACriterio, AResultado);
end;

function TMRVControladorCliente.ProcurarItens(const ACriterio: TMRVDadosBase;
  const AListaResultado: TMRVListaBase; const ASearchOption: TMRVSearchOption): Boolean;
begin
  Result := FCadastroCliente.ProcurarItems(ACriterio, AListaResultado, ASearchOption);
end;

procedure TMRVControladorCliente.ExistemDependencias(const AItem: TMRVDadosBase);
begin
  inherited;
end;

function TMRVControladorCliente.RecuperarItens(const ACriterio: TMRVDadosBase;
  const AListaResultado: TMRVListaBase; const ASearchOption: TMRVSearchOption): Boolean;
var
  LIndex: Integer;
begin
  { esse m�todo � utilizados quando existem objetos agregados }

  Result := FCadastroCliente.ProcurarItems(ACriterio, AListaResultado, ASearchOption);
  for LIndex := 0 to AListaResultado.Count - 1 do
  begin
    Self.ComplementarDados(AListaResultado.ProcurarPorIndice(LIndex));
  end;
end;

procedure TMRVControladorCliente.TipoClienteExiste(const ACliente: TMRVCliente);
var
  LTipoCliente: TMRVTipoCliente;
begin
  { verifica se o tipo de cliente existe }
  LTipoCliente := TMRVTipoCliente.Create;
  try
    { recupera o ID para consulta }
    LTipoCliente.TipoClienteId := ACliente.TipoClienteId;
    { faz a consulta }
    if not FCadastroTipoCliente.ProcurarItem(LTipoCliente) then
    begin
      { se n�o existir ent�o informa que n�o pode cadastrar }
      raise EMRVTipoClienteNaoCadastrado.Create;
    end;
  finally
    LTipoCliente.Free;
  end;
end;

procedure TMRVControladorCliente.ComplementarDados(const AItem: TMRVDadosBase);
begin
  { esse m�todo � utilizados quando existem objetos agregados }
end;

end.


