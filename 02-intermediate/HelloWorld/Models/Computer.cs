using System.Text.Json.Serialization;

namespace HelloWorld.Models
{
    public class Computer
    {
        [JsonPropertyName("computer_id")]
        public int ComputerId { get; set; }
        // private string _motherboard;
        // private string Motherboard { get { return _motherboard}; set { _motherboard = value}; }
        [JsonPropertyName("motherboard")]
        public string Motherboard { get; set; } = "";
        [JsonPropertyName("cpu_cores")]
        public int? CPUCores { get; set; } = 0;
        [JsonPropertyName("has_wifi")]
        public bool HasWifi { get; set; }
        [JsonPropertyName("has-lte")]
        public bool HasLTE { get; set; }
        [JsonPropertyName("release-date")]
        public DateTime? ReleaseDate { get; set; }
        [JsonPropertyName("price")]
        public decimal Price { get; set; }
        [JsonPropertyName("video-card")]
        public string VideoCard { get; set; } = "";
        // public Computer()
        // {
        //     if (VideoCard == null)
        //     {
        //         VideoCard = "";
        //     }
        //     if (Motherboard == null)
        //     {
        //         Motherboard = "";
        //     }
        // }
    }

}