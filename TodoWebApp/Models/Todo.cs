using System.ComponentModel.DataAnnotations;

namespace TodoWebApp.Models;

public partial class Todo
{
    public int Id { get; set; }

    public int? CategoryId { get; set; }

    public int UserId { get; set; }

    public string? Title { get; set; }

    public string? Description { get; set; }

    public DateTime? Deadline { get; set; }

    public DateTime? StartTime { get; set; }

    public DateTime? Endtime { get; set; }

    public bool? Status { get; set; }
}
