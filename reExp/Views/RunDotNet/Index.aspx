﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<reExp.Controllers.rundotnet.RundotnetData>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%if (!string.IsNullOrEmpty(Model.Title))
    {
        %><%:Model.Title%>, <%:Model.LanguageChoice.ToLanguage()%> - rextester<%
    }
    else
    {
        %>Compile and run code snippet<%
    }%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%if (!string.IsNullOrEmpty(Model.Title))
      {%>
            <h2 style="margin-top:0.5em; margin-bottom:0.5em; word-wrap: break-word;" title="<%:Model.Title%>"><%:Model.Title.Length > 70 ? Model.Title.Substring(0, 70) + "..." : Model.Title%></h2>
    <%}
      else
      {%>
            <h2>run code</h2>
      <%} %>
    <%using (Html.BeginForm("Index", "rundotnet", FormMethod.Post, new {id = "mainForm"}))
      {%>
        <div class="formcontent" style="padding-top: 0.5em; <%:Model.IsSaved ? "margin-bottom: 0.5em;" : "margin-bottom: 2em;"%>">
            <table style="width: 95%; margin:0;">
                <tr>
                    <td align="left">
                        <span style="margin: 0 0.5em 0 0">Language:</span><%:Html.DropDownListFor(f => f.LanguageChoiceWrapper, Model.Languages)%>
                        <span style="margin: 0 0.5em 0 0.5em">Editor:</span><%:Html.DropDownListFor(f => f.EditorChoiceWrapper, Model.Editor)%>
                    </td>
                </tr>
            </table>
            
            <%if (Model.IsLive)
              {%>
                <table style="width: 95%; margin-top:1em;table-layout:fixed;">
                    <tr>
                        <td rowspan="2" style="width:80%;">
                            <textarea class="editor" spellcheck="false" cols="1000" id="Program" name="Program" rows="30" style="width: 100%;resize:none;">Loading live document...</textarea>
                        </td>
                        <td id="chatarea" style="display:none;width:20%;" valign="top">
                            <textarea id="chatAreaText" readonly="readonly" spellcheck="false" style="width:94%;height:395px; border: solid 1px gray;resize:none;margin-left:1em;background-color:#FFFFBB;" cols="1000"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td id="chatbox" style="display:none;width:20%;" valign="bottom">
                            <textarea id="chatBoxText" idspellcheck="false" style="width:94%;height:80px; border: solid 1px gray; resize:none;margin-left:1em;background-color:#FFFFBB;" cols="1000"></textarea>
                        </td>
                    </tr>
                </table>
            <%}
              else
              { %>
                  <div style="width: 95%; margin-top:1em;">
                        <textarea class="editor" spellcheck="false" cols="1000" id="Program" name="Program" rows="30" style="width: 100%;resize:none;"><%=Model.Program%></textarea>
                  </div>
              <%} %>

            <%if (Model.ShowCompilerArgs) 
            {%>
                <table width="100%" id="CompilerArgsBox" style="display:none; width: 95%; margin-top:0.5em;margin-left:0;">
                    <tr>
                        <td>
                            <pre>&nbsp;<%:Model.Compiler%>&nbsp;</pre>
                        </td>
                        <td style="width:100%">
                            <input spellcheck="false" style="width:100%;border-style:solid;border-width:1px;border-color:#FF9900;" maxlength="5000" type="text" name="CompilerArgs" id="CompilerArgs" value="<%:Model.CompilerArgs %>"/>
                        </td>
                        <%if (!string.IsNullOrEmpty(Model.CompilerPostArgs)) {%>
                        <td>
                            <pre><%:Model.CompilerPostArgs %></pre>
                        </td>
                        <%} %>
                    </tr>
                </table>
            
            <%}%>
            <%if (Model.ShowInput)
              {%>
                <div style="width: 94.5%; margin-top:0.5em;margin-left:0;">                            
                    <textarea spellcheck="false" cols="1000" id="Input" name="Input" rows="5" style="background-color:#FFFFBB;border: solid 1px gray;width: 100%;<%:(string.IsNullOrEmpty(Model.Input)) ? "display:none;":"" %>"><%=Model.Input%></textarea>
                </div>
            <%} %>
            <table style="width: 95%; margin-top:0.5em;">
                <tr>
                    <td align="left">
                        <input id="Run" type="button" value="Run it<%:Model.EditorChoice == EditorsEnum.Codemirror ? " (F8)" : "" %>" />
                        <%
                            string button_content = "";
                            if (Model.IsLive)
                                button_content = "Take snapshot";
                            else if (Model.IsInEditMode)
                                button_content = "Save edits";
                            else if (Model.IsSaved)
                                button_content = "Fork it";
                            else
                                button_content = "Save it";
                        %>
                        <input style="margin-left:1em" id="Save" type="button" value="<%:button_content%>" />    
                        <%if(!Model.IsInterpreted) 
                          {
                              %><%: Html.CheckBoxFor(model => model.ShowWarnings, new { style = "vertical-align: middle; margin-left: 1.5em;" })%>
                                <label for="ShowWarnings" style="margin-left: 0.2em;font-size: 0.85em;vertical-align: middle;">Show compiler warnings</label><%
                        }%>
                        <%if (Model.ShowCompilerArgs)
                        {%>
                        <span id="Args_label" style="margin-left: 0.5em;font-size: 0.85em; cursor:pointer;">[&nbsp;<span id="Expand_args_sign" style="font-size: 0.85em;">+</span>&nbsp;]&nbsp;Compiler args</span>
                        <%} %>
                        <%if (Model.ShowInput)
                        {%>
                        <span id="Input_label" style="margin-left: 0.5em;font-size: 0.85em; cursor:pointer;">[&nbsp;<span id="Expand_input_sign" style="font-size: 0.85em;"><%:(string.IsNullOrEmpty(Model.Input) || Model.IsLive) ? "+" : "-"%></span>&nbsp;]&nbsp;<span id="Expand_input_text">Show input</span></span>
                        <%} %>
                        <%if (Model.LanguageChoice == LanguagesEnum.SqlServer)
                        { %>
                        <a href="../../Content/Schema.png" style="text-decoration: underline;color:Gray;margin-left:20px;">View schema</a>
                        <%} %>
                    </td>
                    <td align="right">
                        <%if (!Model.IsLive)
                        {%>
                            <%if (Model.EditorChoice == EditorsEnum.Codemirror)
                             {%>
                            <input style="margin-left:1em;" id="Live" type="button" value="Live cooperation" />   
                            <%} %>
                        <%}
                          else
                         {%>
                            <%if (Model.EditorChoice == EditorsEnum.Codemirror)
                             {%>
                            <span style="font-size: 0.85em;">Number of participants: <span id="UsersCount">-</span></span> 
                            <span  id="chat" style="font-size: 0.85em; margin-left:0.5em;cursor:pointer;">[&nbsp;<span id="chatsign" style="font-size: 0.85em;">+</span>&nbsp;]&nbsp;</span>
                            <%} %>
                         <%}%>
                        <input style="margin-left:1em;" id="Wall" type="button" value="Put on a wall" />
                        <%if (Model.EditorChoice == EditorsEnum.Codemirror && !Model.IsLive)
                        {%>
                            <input title="Fullscreen (F11), Esc to exit" style="margin-left:1em;" id="Full" type="button" value="F"/>
                        <%}%>
                        <input style="margin-left:1em;" id="Help" type="button" value="?"/>
                    </td>                  
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="margin-top: 0.8em;font-size: 0.85em;" id="Stats"><%:Model.RunStats%>&nbsp;</div>
                    </td>
                </tr>
            </table>

            <input id="Title" name="Title" type="hidden"/>
            <input id="SavedOutput" name="SavedOutput" type="hidden"/>
            <input id="WholeError" name="WholeError" type="hidden"/>
            <input id="WholeWarning" name="WholeWarning" type="hidden"/>
            <input id="StatsToSave" name="StatsToSave" type="hidden"/>
            <input id="CodeGuid" name="CodeGuid" type="hidden" value="<%:Model.CodeGuid%>"/>
            <input id="IsInEditMode" name="IsInEditMode" type="hidden" value="<%:Model.IsInEditMode%>"/>
            <input id="IsLive" name="IsLive" type="hidden" value="<%:Model.IsLive%>"/>
            <% if(Model.IsLive && Model.EditorChoice == EditorsEnum.Codemirror)
               {%>
                    <input id="InitialCode" name="InitialCode" type="hidden" value="<%:Model.Program%>"/>
              <%}
            %>
        </div>

        <%if(Model.IsSaved) 
        {%>
        <table style="width: 95%; margin-top:0;">
            <tr>
                <td align="right">
                    <%if (Model.PrimaryGuid != Model.CodeGuid)
                    {%>
                        <a class="smalllink" href="<%:Utils.BaseUrl+(Model.LivesVersion ? "live/" : "")+Model.PrimaryGuid%>">latest</a>&nbsp;<span class="smalllink">|</span>&nbsp;
                    <%} %>
                    <%if(Model.EditVisible)
                    {%>
                    <a class="smalllink" href="<%:Utils.BaseUrl+"edit"+"/"+Model.CodeGuid%>">edit mode</a>&nbsp;<span class="smalllink">|</span>&nbsp;
                    <%} %>
                    <%if(Model.BackToForkVisible)
                    {%>
                    <a class="smalllink" href="<%:Utils.BaseUrl+Model.CodeGuid %>">fork mode</a>&nbsp;<span class="smalllink">|</span>&nbsp;
                    <%} %>
                    <a class="smalllink" href="<%:Utils.BaseUrl+"history"+"/"+ Model.PrimaryGuid %>">history</a>
                    <%if(Model.IsOnAWall)
                    {%>
                    &nbsp;<span class="smalllink">|</span>&nbsp;<a class="smalllink" href="<%:Utils.BaseUrl+"discussion"+"/"+Model.CodeGuid+"/"+Model.Title.StringToUrl()%>">discussion</a>
                    <%} %>
                </td>
            </tr>
        </table>
        <%} %>

    <%} %>
    <pre id="Link" class="resultarea"><%:Model.IsLive && string.IsNullOrEmpty(Model.WholeError)? "This is (permanent) live collaboration session. You will see changes that others make as well as be able to make your own." : ""%></pre>

    <div id="Warning"><%
        if (Model.ShowWarnings && !string.IsNullOrEmpty(Model.WholeWarning))
        { 
            %><pre style="color: Orange" class="resultarea">Warning(s):</pre><pre id="WarningSpan" class="resultarea"><%:Model.WholeWarning%></pre><%   
        }
    %></div>

    <div id="Error"><%
        if (!string.IsNullOrEmpty(Model.WholeError))
        {
            %><%if(Model.LanguageChoice != LanguagesEnum.Prolog) {%><pre style="color: Red" class="resultarea">Error(s)<%:Model.IsInterpreted ? ", warning(s)" : ""%>:</pre><%}%><pre id="ErrorSpan" class="resultarea"><%:Model.WholeError%></pre><%  
        }                   
    %></div> 
    <pre id="Result" class="resultarea"><%
        if (Model.IsOutputInHtml)
        {
            %><%=Model.Output%><%
        }
        else
        {
            %><%:Model.Output%><%
        }
    %></pre>
    <pre id="Files"></pre>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
    <meta name="Keywords" content="online c#, vb, php, java, python, c, c++ code compiler, online code execution, rundotnet, runcode, online compiler, run code online, snippet, run your code online, programming online, run code, run snippet, execute snippet, execute code, C#, C++, Java, Javascript, Python, Pascal, Ruby, Lua, Perl, Haskell, Assembly" />
    <%if (!string.IsNullOrEmpty(Model.Title))
    {
        %><meta name="Description" content="<%:Model.Title%> in <%:Model.LanguageChoice.ToLanguage()%>" /><%
    }
    else
    {
        %><meta name="Description" content="Rextester - run code snippets in many languages from your browser." /><%
    }%>
    <%if (Model.EditorChoice == EditorsEnum.Codemirror)
     {
             %> <link rel="stylesheet" href="../../Scripts/codemirror3/lib/codemirror.css"/>
                <link rel="stylesheet" href="../../Scripts/codemirror3/addon/display/fullscreen.css"/>
                <link rel="stylesheet" href="../../Scripts/codemirror3/addon/dialog/dialog.css"/><%
            if (Model.LanguageChoice == LanguagesEnum.CSharp || Model.LanguageChoice == LanguagesEnum.FSharp || Model.LanguageChoice == LanguagesEnum.VB)
            { 
                %><link rel="stylesheet" href="../../Scripts/codemirror3/theme/csharp.css"/><%
            }
            else if (Model.LanguageChoice == LanguagesEnum.Java || Model.LanguageChoice == LanguagesEnum.Scala)
            { 
                %><link rel="stylesheet" href="../../Scripts/codemirror3/theme/java.css"/><%
            }
            if (Model.IsIntellisense)
            {            
                %><link rel="stylesheet" href="../../Scripts/codemirror3/addon/hint/show-hint.css"><%
            }
    }%>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <%if (Model.EditorChoice == EditorsEnum.Codemirror)
      {
            %><script src="../../Scripts/codemirror3/lib/codemirror.js" type="text/javascript"></script>
              <script src="../../Scripts/codemirror3/addon/edit/matchbrackets.js" type="text/javascript"></script>
              <script src="../../Scripts/codemirror3/addon/display/fullscreen.js" type="text/javascript"></script>
              <script src="../../Scripts/codemirror3/addon/dialog/dialog.js" type="text/javascript"></script>
              <script src="../../Scripts/codemirror3/addon/search/searchcursor.js" type="text/javascript"></script>
              <script src="../../Scripts/codemirror3/addon/search/search.js" type="text/javascript"></script><%
    }%>
    <%if (Model.IsIntellisense)
    {
            %><script src="../../Scripts/codemirror3/addon/hint/show-hint.js" type="text/javascript"></script><%
    }%>
    <%if (Model.LanguageChoice == LanguagesEnum.CSharp && Model.IsIntellisense)
    {
            %><script src="../../Scripts/codemirror3/addon/hint/csharp-hint.js" type="text/javascript"></script><%
    }%>
    <%if (Model.EditorChoice == EditorsEnum.Editarea)
    {
        %><script src="../../Scripts/editarea/edit_area_full.js" type="text/javascript"></script><%
    }%>
    <%if (Model.IsLive)
    { %>
        <script src="https://cdn.firebase.com/v0/firebase.js"></script>
        <link rel="stylesheet" href="../../Scripts/firepad/firepad.css" />
        <script src="../../Scripts/firepad/firepad-min.js"></script>
    <%} %>
    <script type="text/javascript">
        //<![CDATA[
        <%if(Model.EditorChoice ==  EditorsEnum.Codemirror)
        {
            %>var GlobalEditor;<%
        }%>

        $(document).ready(function () {
                    
            <%if(Model.ShowInput) 
            {%>
            $("#Input_label").click(function() {
                
                $("#Input").toggle();
                if($("#Expand_input_sign").text() == "-") {
                    $("#Expand_input_sign").text("+");
                    $("#Expand_input_text").text("Show input");
                }
                else {
                    $("#Expand_input_sign").text("-");
                    $("#Expand_input_text").text("Hide input");
                }
            });

            $("#Input").bind('keydown', function (e) {
                var code = e.keyCode || e.which;
                if (code == 119 || code == 116) //F8 or F5
                {
                    e.preventDefault();
                    Run();
                }
            });
            <%} %>

            <%if(Model.ShowCompilerArgs) 
            {%>
            $("#Args_label").click(function() {                
                $("#CompilerArgsBox").toggle();
                if($("#Expand_args_sign").text() == "-") {
                    $("#Expand_args_sign").text("+");
                }
                else {
                    $("#Expand_args_sign").text("-");
                }
            });
            $("#CompilerArgs").bind('keydown', function (e) {
                var code = e.keyCode || e.which;
                if (code == 119 || code == 116) //F8 or F5
                {
                    e.preventDefault();
                    Run();
                }
            });
            <%} %>

            <%if(Model.IsLive)
            { %>
            $("#chat").click(function() {       
                $("#chatarea").toggle();
                $("#chatbox").toggle();
                        
                if($("#chatsign").text() == "-") {
                    $("#chatsign").text("+");
                }
                else {
                    ScrollToBottom($("#chatAreaText"));
                    $("#chatsign").text("-");
                    $("#chatsign").css('color', 'black');
                }
            });
            function ScrollToBottom(textArea) {
                textArea.scrollTop(
                    textArea[0].scrollHeight - textArea.height()
                );
            }

                <%if (Model.User_Id != null)
                {%>
            setInterval(function() {
                $.post('/rundotnet/updateliveindex', { code: GlobalEditor.getValue(), chat: $("#chatAreaText").val(), guid: '<%:Model.CodeGuid%>'}, null, 'text'); 
                    }, 60000);
            <%}%>

            <%} %>

            $("#Help").click(function () {
                window.open("<%:Utils.GetUrl(Utils.PagesEnum.Faq)%>",'_blank');
            });
            <%if (Model.EditorChoice == EditorsEnum.Codemirror && !Model.IsLive)
            {%>
                $("#Full").click(function () {
                    if(!GlobalEditor.hasFocus())
                    {
                        GlobalEditor.focus()
                    }
                    GlobalEditor.setOption("fullScreen", !GlobalEditor.getOption("fullScreen"));
                });
            <%}%>

            $("#Save").click(function () {
                <%if(Model.IsOutputInHtml) 
                {%>
                $("#SavedOutput").val($("#Result").html());
                <%} else
                { %>
                $("#SavedOutput").val($("#Result").text());
                <%} %>
                $("#WholeError").val($("#ErrorSpan").text());
                $("#WholeWarning").val($("#WarningSpan").text());
                $("#StatsToSave").val($("#Stats").text());
                Save(1);
            });
            $("#Wall").click(function () {
                $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Title:<br/><br/>&nbsp;&nbsp;&nbsp;<input style=\"border-style:solid;border-width:1px;border-color:#FF9900;\" size=\"100\" type=\"text\" id=\"titleInput\"/>&nbsp;&nbsp;<br/><br/>Choose the wall:<br/>&nbsp;&nbsp;<input type=\"radio\" name=\"wall_group\" value=\"1\" checked>&nbsp;My wall<br/>&nbsp;&nbsp;<input type=\"radio\" name=\"wall_group\" value=\"2\">&nbsp;Code wall<br/><br/><input type=\"button\" id=\"OKButton\" value=\"Ok\"/>&nbsp;&nbsp;&nbsp;<span style=\"color:red\" id=\"titleError\"></span><br/><br/><br/></pre>");
                $("#titleInput").focus();
                $('html, body').animate({ scrollTop: $("#Run").offset().top }, 200);
                $("#OKButton").click(function() {
                    if($("#titleInput").val().trim() == "")
                    {
                        $("#titleError").text("Title shouldn't be empty.");
                        return;
                    }
                    if($("#titleInput").val().length > 500)
                    {
                        $("#titleError").text("Title shouldn't be longer than 500 characters.");
                        return;
                    }
                    $("#Title").val($("#titleInput").val());
                    <%if(Model.IsOutputInHtml) 
                    {%>
                    $("#SavedOutput").val($("#Result").html());
                    <%} else
                    { %>
                    $("#SavedOutput").val($("#Result").text());
                    <%} %>
                    $("#WholeError").val($("#ErrorSpan").text());
                    $("#WholeWarning").val($("#WarningSpan").text());
                    $("#StatsToSave").val($("#Stats").text());
                    if($('input[type=radio]:checked').val() == '1')
                        Save(4);
                    else
                        Save(2);
                });
            });
            <%if(!Model.IsLive) 
            {%>
            $("#Live").click(function () {
                    <%if(Model.IsOutputInHtml) 
                    {%>
                    $("#SavedOutput").val($("#Result").html());
                    <%} else
                    { %>
                    $("#SavedOutput").val($("#Result").text());
                    <%} %>
                    $("#WholeError").val($("#ErrorSpan").text());
                    $("#WholeWarning").val($("#WarningSpan").text());
                    $("#StatsToSave").val($("#Stats").text());
                    Save(3);
                });
            <%} %>
            $("#Run").click(function () {
                Run();
            });
            $("#LanguageChoiceWrapper").change(function () {
                Reload();
            });
            $("#EditorChoiceWrapper").change(function () {
                Reload();
            });            
            var Reload = function () {
                $("#Input").val('');
                $("#SavedOutput").val('');
                $("#WholeError").val('');
                $("#WholeWarning").val('');
                $("#StatsToSave").val('');
                $("#mainForm").submit();
            };

            $.ajaxSetup({
                timeout: 60000,
                error: function (request, status, err) {
                    $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Error occurred ("+err+"). Try again later.</pre>");
                }
            });
        });

        function Save (what) {
            $('html, body').animate({ scrollTop: $("#Link").offset().top }, 500);

            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Saving...</pre>");
            $("#Warning").replaceWith("<div id=\"Warning\"></div>");
            $("#Error").replaceWith("<div id=\"Error\"></div>");
            $("#Result").replaceWith("<pre id=\"Result\" class=\"resultarea\"></pre>");
            $("#Files").replaceWith("<pre id=\"Files\"></pre>");

            <%if(Model.EditorChoice == EditorsEnum.Codemirror) 
            {
                %>$("#Program").val(GlobalEditor.getValue());<%
            }
            else if(Model.EditorChoice == EditorsEnum.Editarea)
            {
                %>$("#Program").val(editAreaLoader.getValue("Program"));<%
            }%>

            var serializedData = $("#mainForm").serialize();
            if(what == 1)
            {
                $.post('/rundotnet/save', serializedData,
                        function (data) {
                            var obj = jQuery.parseJSON(data);
                            if(obj.Errors != null)
                            {
                                $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\"></pre>");
                                $("#Error").replaceWith("<div id=\"Error\"><pre style=\"color: Red\" class=\"resultarea\">Error:</pre><pre id=\"ErrorSpan\" class=\"resultarea\"></pre></div>");
                                $("#ErrorSpan").text(obj.Errors.replace(/\r/g, ""));
                                return;
                            }                    
                            if(obj.Updated == true)
                                <%if(Model.IsLive) 
                                {%>
                                $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Snapshot taken</pre>");
                                <%}
                                else
                                {%>
                            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Version created, updates saved</pre>");
                                <%} %>
                        else        
                                $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Permanent link: <a href=\""+obj.Url+"\">"+obj.Url+"</a></pre>");
                        }, 'text');
            }
            else if(what == 2)
            {
                $.post('/rundotnet/saveonwall', serializedData,
                    function (data) {
                        var obj = jQuery.parseJSON(data);
                        if(obj.Errors != null)
                        {
                            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\"></pre>");
                            $("#Error").replaceWith("<div id=\"Error\"><pre style=\"color: Red\" class=\"resultarea\">Error:</pre><pre id=\"ErrorSpan\" class=\"resultarea\"></pre></div>");
                            $("#ErrorSpan").text(obj.Errors.replace(/\r/g, ""));
                            return;
                        }                        
                        $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">This snippet is on a wall, permanent link: <a href=\""+obj.Url+"\">"+obj.Url+"</a></pre>");
                    }, 'text');       
            }
            else if(what == 4)
            {
                $.post('/rundotnet/saveonpersonalwall', serializedData,
                    function (data) {
                        var obj = jQuery.parseJSON(data);
                        if(obj.NotLoggedIn == true)
                        {
                            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Please <a href=\"login\">log in</a> first.</pre>");
                            return;
                        }
                        else if(obj.Errors != null)
                        {
                            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\"></pre>");
                            $("#Error").replaceWith("<div id=\"Error\"><pre style=\"color: Red\" class=\"resultarea\">Error:</pre><pre id=\"ErrorSpan\" class=\"resultarea\"></pre></div>");
                            $("#ErrorSpan").text(obj.Errors.replace(/\r/g, ""));
                            return;
                        }                        
                        $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">This snippet is on a wall, permanent link: <a href=\""+obj.Url+"\">"+obj.Url+"</a></pre>");
                    }, 'text');       
            }
            <%if(!Model.IsLive) 
            {%>
            else if(what == 3)
            {
                $.post('/rundotnet/savelive', serializedData,
                    function (data) {
                        var obj = jQuery.parseJSON(data);
                        if(obj.Errors != null)
                        {
                            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\"></pre>");
                            $("#Error").replaceWith("<div id=\"Error\"><pre style=\"color: Red\" class=\"resultarea\">Error:</pre><pre id=\"ErrorSpan\" class=\"resultarea\"></pre></div>");
                            $("#ErrorSpan").text(obj.Errors.replace(/\r/g, ""));
                            return;
                        }                        
                        $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Permanent live session created at <a href=\""+obj.Url+"\">"+obj.Url+"</a>\nAnyone who visits this link can edit code and see changes that others make in real-time.</pre>");
                    }, 'text');       
            }
            <%} %>
        };

        function Run () {
            $('html, body').animate({ scrollTop: $("#Link").offset().top }, 500);

            $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\">Working...</pre>");
            $("#Warning").replaceWith("<div id=\"Warning\"></div>");
            $("#Error").replaceWith("<div id=\"Error\"></div>");
            $("#Result").replaceWith("<pre id=\"Result\" class=\"resultarea\"></pre>");
            $("#Files").replaceWith("<pre id=\"Files\"></pre>");

            <%if(Model.EditorChoice == EditorsEnum.Codemirror) 
            {
                %>$("#Program").val(GlobalEditor.getValue());<%
            }
            else if(Model.EditorChoice == EditorsEnum.Editarea)
            {
                %>$("#Program").val(editAreaLoader.getValue("Program"));<%
            }%>
            
            var serializedData = $("#mainForm").serialize();
            $.post('/rundotnet/Run', serializedData,
                    function (data) {
                        $("#Link").replaceWith("<pre id=\"Link\" class=\"resultarea\"></pre>");                        
                        var obj = jQuery.parseJSON(data);
                        if(obj.Warnings != null)
                        {
                            $("#Warning").replaceWith("<div id=\"Warning\"><pre style=\"color: Orange\" class=\"resultarea\">Warning(s):</pre><pre id=\"WarningSpan\" class=\"resultarea\"></pre></div>");
                            $("#WarningSpan").text(obj.Warnings.replace(/\r/g, ""));
                        }
                        if(obj.Errors != null)
                        {
                            $("#Error").replaceWith("<div id=\"Error\"><%if(Model.LanguageChoice != LanguagesEnum.Prolog) { %><pre style=\"color: Red\" class=\"resultarea\">Error(s)"+'<%:Model.IsInterpreted ? ", warning(s)" : ""%>'+":</pre><%}%><pre id=\"ErrorSpan\" class=\"resultarea\"></pre></div>");
                            $("#ErrorSpan").text(obj.Errors.replace(/\r/g, ""));
                        }

                        <%if(Model.IsOutputInHtml) 
                        {%>
                        if(obj.Result != null)
                            $("#Result").html(obj.Result);
                        <%}
                        else
                        { %>
                        if(obj.Result != null)
                            $("#Result").text(obj.Result.replace(/\r/g, ""));
                        <%} %>
                        if(obj.Files != null)
                        {
                            for (var key in obj.Files) 
                            {             
                                var img_div = $(document.createElement('div'));
                                var img = $(document.createElement('img'));
                                img.attr('src', "data:image/png;base64," + obj.Files[key]).height(600).width(700);
                                img.appendTo(img_div);
                                img_div.appendTo($('#Files'));
                            }
                        }
                        $("#Stats").text(obj.Stats);

                        $('html, body').animate({ scrollTop: $("#Run").offset().top }, 500);
                    }, 'text');
        };

        function keyEvent(cm, e) {
            // Hook into F8 (and F5)
            if ((e.keyCode == 116 || e.keyCode == 119) && e.type == 'keydown') {
                e.stop();                
                Run();
            }
            <% if(Model.IsIntellisense)
            {%>
            if ((e.keyCode == 190) && e.type == 'keyup' && !e.shiftKey) {
                    
                    <%if(Model.LanguageChoice == LanguagesEnum.CSharp)
                    {%>
                    CodeMirror.showHint(cm, CodeMirror.hint.csharp, {async: true});
                    <%}%>
                }
            <%} %>
        }
        //]]>
    </script>
  
    <% Html.RenderPartial("EditorControl", Model); %>

</asp:Content>
