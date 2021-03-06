﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using reExp.Models;
using reExp.Utils;
using System.Web.Script.Serialization;
using System.Threading;

namespace reExp.Controllers.rundotnet
{
    class JsonData
    {
        public bool NotLoggedIn
        {
            get;
            set;
        }
        public string Url
        {
            get;
            set;
        }
        public string Warnings
        {
            get;
            set;
        }
        public string Errors
        {
            get;
            set;
        }
        public string Result
        {
            get;
            set;
        }
        public string Stats
        {
            get;
            set;
        }
        public bool Updated
        {
            get;
            set;
        }
        public List<string> Files
        {
            get;
            set;
        }
    }

    class JsonDataSubset
    {
        public string Warnings
        {
            get;
            set;
        }
        public string Errors
        {
            get;
            set;
        }
        public string Result
        {
            get;
            set;
        }
        public string Stats
        {
            get;
            set;
        }
        public List<string> Files
        {
            get;
            set;
        }
    }


    public class RunDotNetController : Controller
    {
        [ValidateInput(false)]
        public ActionResult Index(RundotnetData data, string savedNr = null)
        {
            Compression.SetCompression();

            //retrieve saved code
            savedNr = savedNr ?? HttpContext.Request.QueryString["code"];
            if (!string.IsNullOrEmpty(savedNr))
            {
                var code = Model.GetCode(savedNr, false);
                if (code == null)
                {
                    throw new HttpException(404, "not found");
                }
                data.Title = code.Title;
                data.Program = code.Program;
                data.Input = code.Input;
                data.CompilerArgs = code.CompilerArgs;
                data.Output = code.Output;
                data.LanguageChoice = (LanguagesEnum)code.Lang;
                data.EditorChoice = (EditorsEnum)code.Editor;
                data.WholeError = code.WholeError;
                data.WholeWarning = code.Warnings;
                data.ShowWarnings = code.ShowWarnings;
                data.RunStats = code.Stats;
                data.CodeGuid = code.Guid;
                data.Votes = code.Votes;

                data.IsInEditMode = false;
                data.EditVisible = code.IsPrimaryVersion;
                data.BackToForkVisible = false;
                data.PrimaryGuid = code.PrimaryGuid == null ? data.CodeGuid : code.PrimaryGuid;
                data.IsSaved = true;
                if (data.PrimaryGuid != data.CodeGuid)
                {
                    data.LivesVersion = Model.IsLive(data.PrimaryGuid);
                }

                return View(data);
            }

            data.IsLive = false;
            data.IsInEditMode = false;

            if ((int)data.LanguageChoice != (int)LanguagesEnum.Unknown && (int)data.EditorChoice != (int)EditorsEnum.Unknown)
                Model.SaveUserProfile(data.LanguageChoice, data.EditorChoice);

            UserProfile profile = null;
            if ((int)data.LanguageChoice == (int)LanguagesEnum.Unknown || (int)data.EditorChoice == (int)EditorsEnum.Unknown)
                profile = Model.GetUserProfile();

            if ((int)data.LanguageChoice == (int)LanguagesEnum.Unknown)
                data.LanguageChoice = profile.LanguageChoice;

            if ((int)data.EditorChoice == (int)EditorsEnum.Unknown)
                data.EditorChoice = profile.EditorChoice;

            data.Program = data.GetInitialCode(data.LanguageChoice, data.EditorChoice);
            data.CompilerArgs = data.GetInitialCompilerArgs(data.LanguageChoice);
            return View(data);
        }
        int maxChars = 300000;
        [HttpPost]
        [ValidateInput(false)]
        public string Save(RundotnetData data)
        {
            Compression.SetCompression();
            JavaScriptSerializer json = new JavaScriptSerializer();

            if (!string.IsNullOrEmpty(data.Program) && data.Program.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Program is too long (max is {0} characters).\n", maxChars) });
            }

            if (!string.IsNullOrEmpty(data.Input) && data.Input.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Input is too long (max is {0} characters).\n", maxChars) });
            }

            string url = null;
            if (data.Program == null)
                data.Program = string.Empty;
            if (!string.IsNullOrEmpty(data.WholeError))
                data.Status = GlobalConst.RundotnetStatus.Error;
            else
                data.Status = GlobalConst.RundotnetStatus.OK;

            if (data.IsInEditMode || data.IsLive)
            {
                Model.UpdateCode(data);
                return json.Serialize(new JsonData() { Updated = true });
            }
            else
            {
                string guid = Model.SaveCode(data);
                if (!string.IsNullOrEmpty(guid))
                    url = Utils.Utils.BaseUrl + guid;
                return json.Serialize(new JsonData() { Url = url });
            }
        }

        [HttpPost]
        [ValidateInput(false)]
        public string SaveOnWall(RundotnetData data)
        {
            Compression.SetCompression();
            JavaScriptSerializer json = new JavaScriptSerializer();

            if (!string.IsNullOrEmpty(data.Program) && data.Program.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Program is too long (max is {0} characters).\n", maxChars) });
            }

            if (!string.IsNullOrEmpty(data.Input) && data.Input.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Input is too long (max is {0} characters).\n", maxChars) });
            }
            if (!string.IsNullOrEmpty(data.Title) && data.Title.Length > 500)
            {
                return json.Serialize(new JsonData() { Errors = "Title is too long (max is 500 characters).\n" });
            }
            string url = null;
            if (data.Program == null)
                data.Program = string.Empty;
            if (!string.IsNullOrEmpty(data.WholeError))
                data.Status = GlobalConst.RundotnetStatus.Error;
            else
                data.Status = GlobalConst.RundotnetStatus.OK;
            string guid = Model.SaveCode(data, true);
            if (!string.IsNullOrEmpty(guid))
                url = Utils.Utils.BaseUrl + guid;

            return json.Serialize(new JsonData() { Url = url });
        }

        [HttpPost]
        [ValidateInput(false)]
        public string SaveOnPersonalWall(RundotnetData data)
        {
            Compression.SetCompression();
            JavaScriptSerializer json = new JavaScriptSerializer();

            if (!SessionManager.IsUserInSession())
            {
                return json.Serialize(new JsonData() { NotLoggedIn = true });
            }

            if (!string.IsNullOrEmpty(data.Program) && data.Program.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Program is too long (max is {0} characters).\n", maxChars) });
            }

            if (!string.IsNullOrEmpty(data.Input) && data.Input.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Input is too long (max is {0} characters).\n", maxChars) });
            }
            if (!string.IsNullOrEmpty(data.Title) && data.Title.Length > 500)
            {
                return json.Serialize(new JsonData() { Errors = "Title is too long (max is 500 characters).\n" });
            }
            string url = null;
            if (data.Program == null)
                data.Program = string.Empty;
            if (!string.IsNullOrEmpty(data.WholeError))
                data.Status = GlobalConst.RundotnetStatus.Error;
            else
                data.Status = GlobalConst.RundotnetStatus.OK;
            string guid = Model.SaveCode(data: data, personal: true);
            if (!string.IsNullOrEmpty(guid))
                url = Utils.Utils.BaseUrl + guid;

            return json.Serialize(new JsonData() { Url = url });
        }

        [HttpPost]
        [ValidateInput(false)]
        public string SaveLive(RundotnetData data)
        {
            Compression.SetCompression();
            JavaScriptSerializer json = new JavaScriptSerializer();

            if (!string.IsNullOrEmpty(data.Program) && data.Program.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Program is too long (max is {0} characters).\n", maxChars) });
            }

            if (!string.IsNullOrEmpty(data.Input) && data.Input.Length > maxChars)
            {
                return json.Serialize(new JsonData() { Errors = string.Format("Input is too long (max is {0} characters).\n", maxChars) });
            }

            string url = null;
            if (data.Program == null)
                data.Program = string.Empty;
            if (!string.IsNullOrEmpty(data.WholeError))
                data.Status = GlobalConst.RundotnetStatus.Error;
            else
                data.Status = GlobalConst.RundotnetStatus.OK;
            string guid = Model.SaveCode(data, false, true);

            Model.MakeLiveCode(guid, Utils.Utils.GetGuid());

            if (!string.IsNullOrEmpty(guid))
                url = Utils.Utils.BaseUrl + "live/" + guid;

            return json.Serialize(new JsonData() { Url = url });
        }

        [HttpPost]
        [ValidateInput(false)]
        public void UpdateLiveIndex(string code, string chat, string guid)
        {
            Model.UpdateLiveCache(code, chat, guid);
        }


        [HttpGet]
        [ValidateInput(false)]
        public ViewResult GetLiveCode(string savedNr)
        {
            Compression.SetCompression();
            RundotnetData data = new RundotnetData();
            var code = Model.GetLiveCode(savedNr);
            if (code == null)
            {
                throw new HttpException(404, "not found");
            }

            data.Program = code.Program;
            data.Input = code.Input;
            data.CompilerArgs = code.CompilerArgs;
            data.LanguageChoice = (LanguagesEnum)code.Lang;
            data.EditorChoice = (EditorsEnum)code.Editor;
            data.ShowWarnings = code.ShowWarnings;
            data.CodeGuid = savedNr;
            data.User_Id = code.UserId;

            data.PrimaryGuid = data.CodeGuid;
            data.IsLive = true;
            data.IsSaved = true;
            data.DisplayName = SessionManager.IsUserInSession() ? SessionManager.UserName : Utils.Utils.RandomLetter();

            return View("Index", data);
        }

        [HttpGet]
        [ValidateInput(false)]
        public ViewResult GetEditCode(RundotnetData data, string savedNr)
        {
            Compression.SetCompression();
            var code = Model.GetCode(savedNr, false);
            if (code == null)
            {
                throw new HttpException(404, "not found");
            }
            data.Title = code.Title;
            data.Program = code.Program;
            data.Input = code.Input;
            data.Output = code.Output;
            data.CompilerArgs = code.CompilerArgs;
            data.LanguageChoice = (LanguagesEnum)code.Lang;
            data.EditorChoice = (EditorsEnum)code.Editor;
            data.WholeError = code.WholeError;
            data.WholeWarning = code.Warnings;
            data.ShowWarnings = code.ShowWarnings;
            data.RunStats = code.Stats;
            data.CodeGuid = code.Guid;
            data.IsSaved = true;
            data.Votes = code.Votes;

            data.IsInEditMode = code.IsPrimaryVersion;
            data.EditVisible = false;
            data.BackToForkVisible = code.IsPrimaryVersion;
            data.PrimaryGuid = code.PrimaryGuid == null ? data.CodeGuid : code.PrimaryGuid;

            return View("Index", data);
        }

        [HttpPost]
        [ValidateInput(false)]
        public string Run(RundotnetData data)
        {
            Compression.SetCompression();
            JavaScriptSerializer json = new JavaScriptSerializer();

            if (!string.IsNullOrEmpty(data.Program) && data.Program.Length > maxChars)
            {
                return json.Serialize(new JsonDataSubset() { Errors = string.Format("Program is too long (max is {0} characters).\n", maxChars) });
            }
            if (!string.IsNullOrEmpty(data.Input) && data.Input.Length > maxChars)
            {
                return json.Serialize(new JsonDataSubset() { Errors = string.Format("Input is too long (max is {0} characters).\n", maxChars) });
            }

            data.Warnings = new List<string>();
            data.Errors = new List<string>();

            //var cache = Model.GetRundotnetDataFromRedis(data);
            //if (cache != null)
            //{
            //    Utils.Log.LogCodeToDB(data.Program, data.Input, data.CompilerArgs, data.Output, (int)data.LanguageChoice, data.IsApi);
            //    return json.Serialize(new JsonDataSubset() { Warnings = data.ShowWarnings || data.IsApi ? cache.WholeWarning : null, Errors = cache.WholeError, Result = cache.WholeOutput, Stats = cache.RunStatus + " (cached)" });
            //}
            //else
            //{
            data = RundotnetLogic.RunProgram(data);
            string warnings = null, errors = null;
            if (data.Warnings.Count() != 0)
                warnings = data.Warnings.Aggregate((a, b) => a + "\n" + b);
            if (data.Errors.Count() != 0)
                errors = data.Errors.Aggregate((a, b) => a + "\n" + b);
            //ThreadPool.QueueUserWorkItem(f =>
            //    { 
            //        data.WholeWarning = warnings;
            //        data.WholeError = errors;
            //        Model.InsertRundotnetDataToRedis(data);
            //    });
            return json.Serialize(new JsonDataSubset() { Warnings = data.ShowWarnings || data.IsApi ? warnings : null, Errors = errors, Result = data.Output, Stats = data.RunStats, Files = data.Files });
            //}
        }

        [AcceptVerbs(HttpVerbs.Get | HttpVerbs.Post)]
        [ValidateInput(false)]
        public ContentResult Api(RundotnetData data)
        {
            Response.AppendHeader("Access-Control-Allow-Origin", "*");
            data.IsApi = true;
            return this.Content(Run(data), "application/json");
        }
    }
}
