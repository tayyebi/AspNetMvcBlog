using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nature.Controllers
{
    [Authenticate]
    public class AdminController : Controller
    {
        DcDataContext dc = new DcDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View(dc.v_Admins.ToList());
        }

        // GET: Admin/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Create
        [HttpPost]
        public ActionResult Create(string Username, string Password, string ConfirmPass, string Fullname)
        {
            try
            {
                if (Password != ConfirmPass)
                {
                    ViewBag.Message = "کلمه عبور با تکرار آن همخوانی ندارد";
                    return View();
                }
                dc.p_Admin_Insert(Username, Password, Fullname);
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
                return View();
            }
        }

        // GET: Admin/Edit/5
        public ActionResult Edit(string id)
        {
            if (id != "" && id != null)
            {
                ViewBag.Message = "شما در حال وارد کردن اطلاعات جدید برای " + id + " هستید";
                return View();
            }
            else
            {
                return HttpNotFound();
            }
        }

        // POST: Admin/Edit/5
        [HttpPost]
        public ActionResult Edit(string id, string Password, string ConfirmPass, string Fullname)
        {
            try
            {
                if (Password != ConfirmPass)
                {
                    ViewBag.Message = "کلمه عبور با تکرار آن همخوانی ندارد";
                    return View();
                }
                dc.p_Admin_Update(id, Password, Fullname);
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
                return View();
            }
        }
    }
}
