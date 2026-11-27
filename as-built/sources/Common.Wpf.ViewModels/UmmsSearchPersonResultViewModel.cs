using System;
using Common.Data.Models.Umms;

namespace Common.Wpf.ViewModels
{
    public class UmmsSearchPersonResultViewModel : BaseViewModel
    {
        public UmmsPersonModel UmmsSearchPersonResult { get; private set; }

        public UmmsSearchPersonResultViewModel(UmmsPersonModel ummsSearchPersonResult)
        {
            UmmsSearchPersonResult = ummsSearchPersonResult;
        }

        public int Index { get; set; }

        public String PersonId { get { return UmmsSearchPersonResult.PersonId; } }
        public String Name { get { return UmmsSearchPersonResult.Name; } }
        public String DateOfBirth { get { return UmmsSearchPersonResult.DateOfBirth; } }
        public String DateOfDeath { get { return UmmsSearchPersonResult.DateOfDeath; } }
        public String PlaceOfBirth { get { return UmmsSearchPersonResult.PlaceOfBirth; } }
        public String LastIssuedDocument { get { return UmmsSearchPersonResult.LastIssuedDocument; } }
        public bool HidingAttribute { get { return UmmsSearchPersonResult.HidingAttribute; } }

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
