using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Diagnostics;
using TodoWebApp.Models;

namespace TodoWebApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public string UriAPI { get { return "http://localhost:5171/api/"; } }
        public string UriTodoLists { get { return "todolist"; } }
        public string UriTodo { get { return "Todo"; } }
        public string UriUsers { get { return "users"; } }
        public string UriCategories { get { return "categories"; } }

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        private async Task<List<ViewTodo>> GetTodoList()
        {
            List<ViewTodo>? list = new List<ViewTodo>();

            try
            {
                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(UriAPI);
                HttpResponseMessage response = await client.GetAsync(UriTodoLists);
                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    list = JsonConvert.DeserializeObject<List<ViewTodo>>(content);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }

            return list;
        }

        private async Task<List<User>> GetUsers()
        {
            List<User>? users = new List<User>();

            try
            {
                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(UriAPI);
                HttpResponseMessage response = await client.GetAsync(UriUsers);
                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    users = JsonConvert.DeserializeObject<List<User>>(content);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }

            return users;
        }

        private async Task<List<Category>> GetCategories()
        {
            List<Category>? categories = new List<Category>();

            try
            {
                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(UriAPI);
                HttpResponseMessage response = await client.GetAsync(UriCategories);
                if (response.IsSuccessStatusCode)
                {
                    string content = await response.Content.ReadAsStringAsync();
                    categories = JsonConvert.DeserializeObject<List<Category>>(content);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }

            return categories;
        }

        [HttpPost]
        public async void TodoCreate(IFormCollection form)
        {
            try
            {
                Todo newTodo = new Todo
                {
                    CategoryId = Convert.ToInt32(form["categories"]),
                    UserId = Convert.ToInt32(form["users"]),
                    Title = form["todotitle"],
                    Description = form["tododescription"],
                    Deadline = form["tododeadline"] == "" || Convert.ToDateTime(form["tododeadline"]) <= new DateTime(1753, 1, 1, 0, 0, 0) ? DateTime.Now : Convert.ToDateTime(form["tododeadline"]),
                    StartTime = DateTime.Now,
                    Endtime = DateTime.Now,
                    Status = form["todostatus"] == "on" ? true : false
                };

                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(UriAPI);
                HttpResponseMessage response = await client.PostAsJsonAsync($"{UriTodo}", newTodo);
                if (response.IsSuccessStatusCode)
                {

                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
        }

        [Route("/todolist")]
        public async Task<IActionResult> TodoList()
        {
            List<ViewTodo> todoList = await GetTodoList();

            return View(todoList);
        }

        public async Task<IActionResult> TodoRead(int id)
        {
            List<ViewTodo> todoLists = await GetTodoList();
            List<User> users = await GetUsers();
            List<Category> categories = await GetCategories();

            ViewTodo todo = todoLists.Where(todo => todo.Id == id).FirstOrDefault();

            // id == 0 : create , id > 0 : update
            if (todo == null)
            {
                todo = new ViewTodo
                {
                    Deadline = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day+7),
                    StartTime = DateTime.Now,
                };
            }

            ViewData["Users"] = users;
            ViewData["Categories"] = categories;
            return PartialView("/Views/Partial/TodoRead.cshtml", todo);
        }

        [HttpPut]
        public async void TodoUpdate(IFormCollection form)
        {
            try
            {
                Todo updatedTodo = new Todo
                {
                    Id = Convert.ToInt32(form["todoId"]),
                    CategoryId = Convert.ToInt32(form["categories"]),
                    UserId = Convert.ToInt32(form["users"]),
                    Title = form["todotitle"],
                    Description = form["tododescription"],
                    Deadline = Convert.ToDateTime(form["tododeadline"]),
                    StartTime = DateTime.Now,
                    Endtime = DateTime.Now,
                    Status = form["todostatus"] == "on" ? true : false
                };

                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(UriAPI);
                HttpResponseMessage response = await client.PutAsJsonAsync($"{UriTodo}/{updatedTodo.Id}", updatedTodo);
                if (response.IsSuccessStatusCode)
                {

                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
        }

        [HttpDelete]
        public async void TodoDelete(int id)
        {
            try
            {
                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(UriAPI);
                HttpResponseMessage response = await client.DeleteAsync($"{UriTodo}/{id}");
                if (response.IsSuccessStatusCode)
                {
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
        }

        public IActionResult Index()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}