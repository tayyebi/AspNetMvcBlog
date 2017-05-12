using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nature.Controllers
{
    [Authenticate]
    public class GroupController : Controller
    {
        DcDataContext dc = new DcDataContext();
        // GET: Group
        public ActionResult Index()
        {
            return View(dc.v_Groups.ToList());
        }

        // GET: Group/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Group/Create
        [HttpPost]
        public ActionResult Create(string Name)
        {
            try
            {
                dc.p_Group_Insert(Name);
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
                return View();
            }
        }

        // GET: Group/Edit/5
        public ActionResult Edit(Guid? id)
        {
            ViewBag.Message = "ویرایش این گروه";
            return View();
        }

        // POST: Group/Edit/5
        [HttpPost]
        public ActionResult Edit(Guid id, string Name)
        {
            try
            {
                dc.p_Group_Update(id,Name);
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
                return View();
            }
        }

        // GET: Group/Delete/5
        public ActionResult Delete(Guid? id)
        {
            if (id != null)
            {
                ViewBag.Message = "آیا از حذف این گروه اطمینان دارید؟";
                return View();
            }return HttpNotFound();
        }

        // POST: Group/Delete/5
        [HttpPost]
        public ActionResult Delete(Guid id)
        {
            try
            {
                dc.p_Group_Delete(id);
                    return RedirectToAction("Index");

            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده | گروه هایی که پست ارسال شده داشته باشند حذف نخواهند شد.";
            }
            return View();
        }
    }
}
