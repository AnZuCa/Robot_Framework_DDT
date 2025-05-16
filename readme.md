# 🤖 Robot Framework - Pruebas Automatizadas para Assets API usando enfoque Data Driven Testing 

Este proyecto contiene pruebas automatizadas escritas en **Robot Framework** para validar el correcto funcionamiento de una API REST de gestión de activos (Assets API). Se utilizan pruebas data-driven y autenticación basada en JWT para simular escenarios reales.

## ✅ Requisitos

- Python 3.7+
- pip
- Virtualenv (opcional, pero recomendado)
- Plugins (RobotCode - Robot Framework Support)

## crear entorno virtual
python3 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate


## Ejecutar archivo
Ejemplo: 
robot -d results tests/assets_tests.robot