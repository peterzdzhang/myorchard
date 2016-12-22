using Orchard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Faurecia.ADL.Models;
using Orchard.Data;

namespace Faurecia.ADL.Services
{
    public class ADLService : IADLService
    {
        private const string SignalName = "Faurecia.ADL.Services.ADLService";

        private readonly IRepository<ADLRecord> _adlRepository;

        public ADLService(IRepository<ADLRecord> adlRepository)
        {
            _adlRepository = adlRepository;
        }

        public void Create(ADLRecord record)
        {
            if (record == null) return;
            if (string.IsNullOrEmpty(record.ProjectNo)) return;

            if (GetByProjectNo(record.ProjectNo, record.VersionNo)!=null)
                return;
            _adlRepository.Create(record);
        }

        public void Delete(ADLRecord record)
        {
            throw new NotImplementedException();
        }

        public ADLRecord Get(int id)
        {
            return _adlRepository.Get(id);
        }

        public ADLRecord GetByProjectNo(string projectNo, int versionNo)
        {
            return _adlRepository.Get(item => item.ProjectNo == projectNo && item.VersionNo == versionNo);
        }

        public IEnumerable<ADLRecord> GetList()
        {
            throw new NotImplementedException();
        }

        public void Update(ADLRecord record)
        {
            throw new NotImplementedException();
        }

        public bool VerifyProjectNo(string projectNo)
        {
            throw new NotImplementedException();
        }
    }
}