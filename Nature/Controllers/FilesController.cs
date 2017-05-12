using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nature.Controllers
{
    public class FilesController : Controller
    {
        DcDataContext dc = new DcDataContext();
        [Authenticate]
        public ActionResult Index()
        {
            return View(dc.v_Files.ToList());
        }

        [Authenticate]
        public ActionResult Upload()
        {
            return View();
        }
        [Authenticate]
        [HttpPost]
        public ActionResult Upload(string FileName, HttpPostedFileBase UploadedFile)
        {
            try
            {
                var _Bytes = new byte[UploadedFile.ContentLength];
                UploadedFile.InputStream.Read(_Bytes, 0, UploadedFile.ContentLength);

                dc.p_File_Insert(FileName, UploadedFile.ContentType, _Bytes, UploadedFile.ContentLength);
                ViewBag.Message = "فایل با موفقیت آپلود شد";
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "فایل با موفقیت آپلود نشد!";
            }
            return View();
        }
        public FileResult Download(Guid id)
        {
            var file = dc.v_FileDownloads.Where(y => y.id == id).FirstOrDefault();
            return File(file.Bytes.ToArray(), file.Type, file.Name);
        }
        [Authenticate]
        public ActionResult Delete()
        {
            ViewBag.Message = "آیا از حذف این فایل اطمینان دارید؟";
            return View();
        }
        // POST: Group/Delete/5
        [HttpPost]
        [Authenticate]
        public ActionResult Delete(Guid id)
        {
            try
            {
                dc.p_File_Delete(id);
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
            }
            return View();
        }
    }
}