using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nature.Controllers
{
    [Authenticate]
    public class PostController : Controller
    {
        DcDataContext dc = new DcDataContext();
        // GET: Post
        public ActionResult Index(int id = 10)
        {
            return View(dc.v_Posts.Take(id).OrderByDescending(m => m.Id).Where(m => m.AdminUsername == Session["Username"].ToString()).ToList());
        }


        // GET: Post/Create
        public ActionResult Create()
        {
            return View(dc.v_Groups.ToList());
        }

        // POST: Post/Create
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(string Title, Guid GroupId, string Abstract, string Body)
        {
            try
            {
                dc.p_Post_Insert(Title, Abstract, Body, GroupId, Session["Username"].ToString());
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
                return View(dc.v_Groups.ToList());
            }
        }

        // GET: Post/Edit/5
        public ActionResult Edit(int? id)
        {
            try
            {
                if (id == null)
                    return HttpNotFound();
                var post = dc.v_Post(id).FirstOrDefault();
                ViewBag.PostTitle = post.Title;
                ViewBag.PostAbstract = post.Abstract;
                ViewBag.PostBody = post.Body;
                ViewBag.Message = "ویرایش پست";
                return View(dc.v_Groups.ToList());
            }
            catch
            { return HttpNotFound(); }
        }

        // POST: Post/Edit/5
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(int id, string Title, Guid GroupId, string Abstract, string Body)
        {
            try
            {
                dc.p_Post_Update(id, Title, Abstract, Body, GroupId, Session["Username"].ToString());
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Message = "خطای پایگاه داده";
                return View();
            }
        }

        // GET: Post/Delete/5
        public ActionResult Delete(int id)
        {
            ViewBag.Message = "آیا از حذف این پست اطمینان دارید؟";
            return View();
        }

        // POST: Post/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                dc.p_Post_Delete(id);
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