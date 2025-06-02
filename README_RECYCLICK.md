
# ♻️ Recyclick

**Aplicativo Ecológico Educacional**  
Desenvolvido como projeto de estudo para a disciplina de Desenvolvimento para Dispositivos Móveis – IFSP Campus Itapetininga.

---

## 📱 Descrição do Projeto

O Recyclick é um aplicativo Flutter que promove ações sustentáveis por meio de funcionalidades como scanner de materiais recicláveis, desafios ecológicos, diário de reciclagem e localização de ecopontos. O objetivo é incentivar o engajamento ambiental com tecnologia acessível.

---

## 🚀 Funcionalidades

- **Autenticação com Firebase** (e-mail/senha e Google)
- **Scanner de recicláveis** com ML Kit
- **Mapa de ecopontos** usando Google Maps
- **Desafios ecológicos** gamificados
- **Agenda/Diário sustentável** com notificações
- **Armazenamento local** com Hive
- **Notificações locais programadas**

---

## 🧭 Estrutura de Navegação

- **SplashScreen** → Login/Cadastro
- **Home** com BottomNavigationBar:
  - Início (Feed + Tabs: Feed | Network | MyCash | Inspirar)
  - Desafios
  - Mapa
  - Diário
- **Drawer** com:
  - Perfil
  - Conquistas
  - Configurações

---

## 📂 Estrutura de Pastas

```
lib/
├── main.dart
├── models/            # Modelos Hive (Ecoponto, Desafio, EntradaDiario)
├── db/                # Classes de acesso ao Hive
├── screens/           # Telas principais e seções
│   ├── auth/          # Login, Cadastro, EsqueciSenha
│   ├── home/          # Home com Tabs
│   ├── mapa/          # Tela de mapa e ecopontos
│   ├── desafios/      # Missões ecológicas
│   ├── diario/        # Agenda e histórico
├── services/          # Notificações, localização, autenticação
├── widgets/           # Componentes reutilizáveis
assets/
```

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** 3.x
- **Dart** 3.x
- **Firebase** (Auth + Core)
- **Hive** (Armazenamento local)
- **Google Maps & Geolocator**
- **ML Kit**
- **flutter_local_notifications**

---

## 🔐 Segurança

> ⚠️ Este repositório NÃO inclui arquivos sensíveis como:
- `google-services.json`
- `.env` com tokens de API

Para rodar o projeto, configure seu próprio Firebase e gere esses arquivos.

---

## 🧑 Autor

**Hugo Alessi**  
Curso: Pós-graduação em Desenvolvimento Web  
Instituição: IFSP - Campus Itapetininga  
Disciplina: Desenvolvimento para Dispositivos Móveis  
Professora: Acácia Terra

---

## 📦 Executar o Projeto

```bash
git clone https://github.com/SEU_USUARIO/recyclick.git
cd recyclick
flutter pub get
flutter run
```

