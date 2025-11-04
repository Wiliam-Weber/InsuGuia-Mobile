# 🩺 InsuGuia Mobile

Aplicativo Flutter desenvolvido na disciplina **Desenvolvimento para Plataformas Móveis (UNIDAVI)**.

## 👥 Equipe

## 🎯 Objetivo
Aplicativo de apoio à prescrição de insulina hospitalar, com base nas diretrizes da Sociedade Brasileira de Diabetes.

## ⚙️ Tecnologias

## 🚀 Rodar o projeto
No PowerShell (Windows):

```powershell
cd "c:\Users\felip\Desktop\Desenvolvimento Mobile\InsuGuia\InsuGuia-Mobile"
flutter pub get
flutter analyze
flutter run
```

---

## Sobre esta entrega (protótipo acadêmico)

Este repositório contém um protótipo acadêmico chamado *InsuGuia Mobile* que implementa o cenário "Paciente Não Crítico" para suporte à prescrição de insulina.

> AVISO: Este protótipo é educacional e NÃO possui validade clínica. Não use para decisões médicas. Valide todas as regras com profissionais de saúde antes de qualquer uso clínico.

### Funcionalidades implementadas nesta versão
- Cadastro de paciente: nome, sexo, idade, peso, altura, creatinina, local de internação.
- Geração de prescrição sugerida (regra acadêmica): dieta, monitorização, insulina basal (UI/dia), insulina de ação rápida e orientações para hipoglicemia.
- Acompanhamento diário (simulado): inserir glicemias e receber sugestão de correção (armazenamento em memória durante a execução).
- Documentação inicial em `docs/requirements.md` e `docs/design.md`.
- Testes unitários para `PrescriptionService`.

### Estrutura importante
- `lib/models/patient.dart` — modelo Patient atualizado.
- `lib/services/prescription_service.dart` — lógica de prescrição (protótipo acadêmico).
- `lib/screen/patient_form_screen.dart` — formulário de cadastro ampliado.
- `lib/screen/prescription_screen.dart` — exibe prescrição sugerida.
- `lib/screen/monitoring_screen.dart` — acompanhamento diário simulado.

### Próximos passos sugeridos
- Persistência dos registros de glicemia (por exemplo, `shared_preferences` ou SQLite).
- Mais testes unitários e de integração.
- Revisão clínica das regras junto ao Dr. Itairan.

Se quiser que eu implemente qualquer um dos próximos passos (persistência, mais testes, melhor UX, geração de APK), diga qual preferir que eu faça a seguir.
