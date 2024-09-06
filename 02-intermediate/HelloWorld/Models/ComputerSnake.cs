namespace HelloWorld.Models
{
    public class ComputersSnake
    {
        public int computer_id { get; set; }
        // private string _motherboard;
        // private string Motherboard { get { return _motherboard}; set { _motherboard = value}; }
        public string motherboard { get; set; } = "";
        public int? cpu_cores { get; set; } = 0;
        public bool has_wifi { get; set; }
        public bool has_lte { get; set; }
        public DateTime? release_date { get; set; }
        public decimal price { get; set; }
        public string video_card { get; set; } = "";
    }

}