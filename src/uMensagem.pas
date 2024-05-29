unit uMensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmMensagem = class(TForm)
    Label1: TLabel;
  private
    class var fmMensagem: TfmMensagem;
  public
    class procedure Apresentar(AForm: TForm);
    class procedure FecharMsg;
  end;

implementation

{$R *.dfm}

{ TfmMensagem }

class procedure TfmMensagem.Apresentar(AForm: TForm);
begin
  fmMensagem := TfmMensagem.Create(AForm);
  fmMensagem.FormStyle := fsStayOnTop;
  fmMensagem.Left := Trunc((AForm.Width / 2) - (fmMensagem.Width / 2));
  fmMensagem.Top := Trunc((AForm.Height / 2) - (fmMensagem.Height / 2));
  fmMensagem.Visible := True;
  Application.ProcessMessages;
end;

class procedure TfmMensagem.FecharMsg;
begin
  FreeAndNil(fmMensagem);
end;

end.
