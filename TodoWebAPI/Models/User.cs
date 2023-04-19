using System;
using System.Collections.Generic;

namespace TodoWebAPI.Models;

public partial class User
{
    public int Id { get; set; }

    public int RoleId { get; set; }

    public string? Email { get; set; }

    public string? FullName { get; set; }

    public string? Password { get; set; }
}
