# Mirage AR

Aplicativo Flutter de visualização de modelos 3D com suporte a Realidade Aumentada (RA). Permite visualizar modelos `.glb` diretamente no ambiente real (Android).

---

## Pré-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) versão **3.11.0 ou superior**
- [Android Studio](https://developer.android.com/studio) com o plugin Flutter configurado
- [Android SDK](https://developer.android.com/studio) com `minSdk 24` (Android 7.0+)
- Um dispositivo físico Android, ou um emulador com API 24+
- [Git](https://git-scm.com/) para clonar o repositório

---

## Instalação

**1. Clone o repositório**

```bash
git clone https://github.com/seu-usuario/mirage_ar_ofc.git
cd mirage_ar_ofc
```

**2. Instale as dependências**

```bash
flutter pub get
```

---

## Executando o projeto

**Em dispositivo físico Android (recomendado para AR)**

Conecte o dispositivo via USB com depuração USB ativada e execute:

```bash
flutter run
```

**Em emulador**

```bash
flutter emulators --launch <nome-do-emulador>
flutter run
```

> **Atenção:** a funcionalidade de Realidade Aumentada exige um dispositivo físico com ARCore. No emulador, o modelo 3D é exibido normalmente, mas o botão AR pode não funcionar.

**Gerando APK de release**

```bash
flutter build apk --release
```

O arquivo gerado ficará em `build/app/outputs/flutter-apk/app-release.apk`.

---


