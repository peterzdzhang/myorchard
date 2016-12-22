using Faurecia.ADL.Models;
using Orchard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Faurecia.ADL.Services
{
    public interface IADLService: IDependency
    {
         
        IEnumerable<ADLRecord> GetList();
        ADLRecord Get(int id);
        ADLRecord GetByProjectNo(string projectNo, int versionNo);
        void Create(ADLRecord record);
        void Update(ADLRecord record);
        void Delete(ADLRecord record);
        bool VerifyProjectNo(string projectNo);
    }
}
