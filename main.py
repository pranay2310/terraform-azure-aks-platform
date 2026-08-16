from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def root():
    return {
        "message": "Welcome to FastAPI GitOps Demo",
        "platform": "Azure AKS",
        "deployment": "Azure DevOps + Terraform"
    }