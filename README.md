
# Todo.NET

1 solution 2 project (API & MVC)


Tools
```bash
dotnet tool install --global dotnet-ef
dotnet tool install -g dotnet-aspnet-codegenerator
```

Used CLI Commands (API)

```bash
dotnet new webapi

dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design

dotnet ef dbcontext scaffold "Server=ALPER\SQLEXPRESS; Database=TODO; Trusted_Connection=True; MultipleActiveResultSets=true; TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -o "Models" --context-dir "Data" -c "TodoContext" --no-onconfiguring --force

dotnet aspnet-codegenerator controller -name TodoController -async -api -m Todo -dc TodoContext -outDir Controllers
```

Used CLI Commands (APP)

```bash
dotnet new mvc
dotnet add package Microsoft.AspNetCore.Mvc.NewtonsoftJson
```