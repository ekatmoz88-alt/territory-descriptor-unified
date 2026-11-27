using Common.Data.Models.Umms;
using System;

namespace Common.Wpf.ViewModels
{
    /// <summary>
    /// For stationary module
    /// </summary>
    public class UmmsPersonViewModel : BaseViewModel
    {
        public UmmsPersonViewModel(UmmsPersonModel ummsSearchPersonResult)
        {
            PersonId = ummsSearchPersonResult.PersonId;
            Name = ummsSearchPersonResult.Name;
            DateOfBirth = ummsSearchPersonResult.DateOfBirth;
            DateOfDeath = ummsSearchPersonResult.DateOfDeath;
            PlaceOfBirth = ummsSearchPersonResult.PlaceOfBirth;
            LastIssuedDocument = ummsSearchPersonResult.LastIssuedDocument;
            HidingAttribute = ummsSearchPersonResult.HidingAttribute;
        }

        public int Index { get; set; }

        public String PersonId { get; set; }
        public String Name { get; set; }
        public String DateOfBirth { get; set; }
        public String DateOfDeath { get; set; }
        public String PlaceOfBirth { get; set; }
        public String LastIssuedDocument { get; set; }
        public bool HidingAttribute { get; set; }

        public int ScenarioNumber { get; set; }
        public int ScenarioStatus { get; set; }

        private bool _isOpened;

        /// <summary>
        /// Result is opened in tab
        /// </summary>
        public bool IsOpened
        {
            get { return _isOpened; }
            set { _isOpened = value; OnPropertyChanged(); }
        }
    }
}
