﻿CodeMirror.defineMode("octave", function () {
    function words(str) {
        var obj = {}, words = str.split(" ");
        for (var i = 0; i < words.length; ++i) obj[words[i]] = true;
        return obj;
    }
    var keywords = words("__FILE__ __LINE__ break case catch classdef continue do else elseif end end_try_catch end_unwind_protect endclassdef endenumeration endevents endfor endfunction endif endmethods endparfor endproperties endswitch endwhile enumeration events for function get global if methods otherwise parfor persistent properties return set static switch try until unwind_protect unwind_protect_cleanup while ans clc diary format home iskeyword more commandhistory commandwindow syntax accumarray blkdiag diag eye false freqspace linspace logspace meshgrid ndgrid ones rand true zeros cat horzcat vertcat colon end ind2sub sub2ind length ndims numel size iscolumn isempty ismatrix isrow isscalar isvector blkdiag circshift ctranspose diag flipdim fliplr flipud ipermute permute repmat reshape rot90 shiftdim issorted sort sortrows squeeze transpose inline vectorize Arithmetic uplus plus uminus minus times mtimes rdivide ldivide mrdivide mldivide power mpower cumprod cumsum diff prod sum ceil fix floor idivide mod rem round Relational eq ge gt le lt ne isequal isequaln isequalwithequalnans Logical Logical and not or xor all any false find islogical logical true intersect ismember issorted setdiff setxor union unique bitand bitcmp bitget bitmax bitor bitset bitshift bitxor swapbytes Special colon double single int8 int16 int32 int64 uint8 uint16 uint32 uint64 cast typecast isinteger isfloat isnumeric isreal isfinite isinf isnan intmax intmin realmax realmin blanks cellstr char iscellstr ischar sprintf strcat setstr strvcat strings ischar isletter isspace isstrprop sscanf strfind strrep strtok validatestring symvar regexp regexpi regexprep regexptranslate findstr strread strmatch strcmp strcmpi strncmp strncmpi blanks deblank strtrim lower upper strjust struct fieldnames getfield isfield isstruct orderfields rmfield setfield arrayfun structfun cell2struct struct2cell cell cell2mat cell2struct celldisp cellfun cellplot cellstr iscell iscellstr mat2cell num2cell struct2cell deal function_handle feval func2str str2func functions containers.Map isKey keys remove values length size append get getdatasamplesize getqualitydesc getsamples plot set tsdata.event tstool addsample ctranspose delsample detrend filter getabstime getinterpmethod getsampleusingtime idealfilter resample setabstime setinterpmethod synchronize transpose addevent delevent gettsafteratevent gettsafterevent gettsatevent gettsbeforeatevent gettsbeforeevent gettsbetweenevents iqr max mean median min std sum var get isempty length plot set size tscollection tstool addsampletocollection addts delsamplefromcollection getabstime getsampleusingtime gettimeseriesnames horzcat removets resample setabstime settimeseriesnames vertcat is* isa iscell iscellstr ischar isfield isfloat ishghandle isinteger isjava islogical isnumeric isobject isreal isscalar isstr isstruct isvector class validateattributes whos char int2str mat2str num2str str2double str2num native2unicode unicode2native base2dec bin2dec dec2base dec2bin dec2hex hex2dec hex2num num2hex cell2mat cell2struct cellstr mat2cell num2cell struct2cell str2mat addtodate calendar clock cputime date datenum datestr datevec eomday etime now weekday uplus plus uminus minus mtimes times rdivide mrdivide ldivide mldivide power mpower cumprod cumsum diff prod sum ceil fix floor idivide mod rem round sin sind asin asind sinh asinh cos cosd acos acosd cosh acosh tan tand atan atand atan2 atan2d tanh atanh csc cscd acsc acscd csch acsch sec secd asec asecd sech asech cot cotd acot acotd coth acoth hypot exp expm1 log log10 log1p log2 nextpow2 nthroot pow2 reallog realpow realsqrt sqrt abs angle complex conj cplxpair i imag isreal j real sign unwrap factor factorial gcd isprime lcm nchoosek perms primes rat, poly polyder polyeig polyfit polyint polyval polyvalm residue roots airy besselh besseli besselj besselk bessely beta betainc betaincinv betaln ellipj ellipke erf erfc erfcinv erfcx erfinv expint gamma gammainc gammaincinv gammaln legendre psi cart2pol cart2sph pol2cart sph2cart eps i j Inf pi NaN isfinite isinf isnan compan gallery hadamard hankel hilb invhilb magic pascal rosser toeplitz vander wilkinson cross dot kron surfnorm tril triu transpose cond condest funm inv linsolve lscov lsqnonneg pinv rcond chol cholinc ichol cholupdate ilu lu luinc qr qrdelete qrinsert qrupdate planerot ldl cdf2rdf rsf2csf balance cdf2rdf condeig eig eigs gsvd hess ordeig ordqz ordschur poly polyeig qz rsf2csf schur sqrtm ss2tf svd svds gsvd cond condeig det norm normest null orth rank rcond rref subspace trace expm logm sqrtm bsxfun arrayfun accumarray corrcoef cov max mean median min mode std var rng rand randn randi RandStream randperm get RandStream.create RandStream.getDefaultStream RandStream.list RandStream.setDefaultStream rand randi randn randperm RandStream reset set interp1 griddedInterpolant pchip spline ppval mkpp unmkpp padecoef interpft interp1q interp2 interp3 interpn griddedInterpolant ndgrid meshgrid griddata griddatan TriScatteredInterp griddata3 fminbnd fminsearch fzero lsqnonneg optimget optimset ode45 ode15s ode23 ode113 ode23t ode23tb ode23s ode15i decic odextend odeget odeset deval bvp4c bvp5c bvpinit bvpxtend bvpget bvpset deval dde23 ddesd ddensd ddeget ddeset deval pdepe pdeval integral integral2 integral3 quadgk quadv quad quadl quad2d dblquad triplequad cumtrapz polyint trapz del2 diff gradient polyder abs angle cplxpair fft fft2 fftn fftshift fftw ifft ifft2 ifftn ifftshift nextpow2 unwrap conv conv2 convn deconv detrend filter filter2 spdiags speye sprand sprandn sprandsym sparse spconvert issparse nnz nonzeros nzmax spalloc spfun spones spparms spy find full amd colamd colperm dmperm randperm symamd symrcm cholinc condest eigs ilu luinc normest spaugment sprank svds bicg bicgstab bicgstabl cgs gmres lsqr minres pcg qmr symmlq tfqmr etree etreeplot gplot symbfact treelayout treeplot unmesh TriRep circumcenters edgeAttachments edges faceNormals featureEdges freeBoundary incenters isEdge neighbors size vertexAttachments delaunay delaunayn DelaunayTri inOutStatus tetramesh trimesh triplot trisurf delaunay3 baryToCart cartToBary TriRep dsearchn tsearchn nearestNeighbor pointLocation delaunay delaunayn DelaunayTri dsearch tsearch convexHull convhull convhulln patch trisurf patch voronoi voronoiDiagram voronoin polyarea inpolygon rectint plot plotyy plot3 loglog semilogx semilogy errorbar fplot ezplot ezplot3 bar bar3 barh bar3h hist histc area pareto pie pie3 rose stem stairs stem3 scatter scatter3 spy plotmatrix polar rose compass ezpolar contour contourf contourc contour3 contourslice ezcontour ezcontourf feather quiver compass quiver3 streamslice streamline surf surfc surface surfl surfnorm mesh meshc meshz waterfall ribbon contour3 peaks cylinder ellipsoid sphere pcolor surf2patch ezsurf ezsurfc ezmesh ezmeshc contourslice flow isocaps isocolors isonormals isosurface reducepatch reducevolume shrinkfaces slice smooth3 subvolume volumebounds coneplot curl divergence interpstreamspeed stream2 stream3 streamline streamparticles streamribbon streamslice streamtube fill fill3 patch surf2patch movie noanimate drawnow refreshdata frame2im getframe im2frame comet comet3 title xlabel ylabel zlabel clabel datetick texlabel legend colorbar xlim ylim zlim box grid daspect pbaspect axes axis subplot hold gca cla annotation text legend title xlabel ylabel zlabel datacursormode ginput gtext colormap colormapeditor colorbar brighten contrast shading graymon caxis hsv2rgb rgb2hsv rgbplot spinmap colordef whitebg hidden pan reset rotate rotate3d selectmoveresize zoom datacursormode figurepalette plotbrowser plotedit plottools propertyeditor showplottool brush datacursormode linkdata refreshdata view makehgtform viewmtx cameratoolbar campan camzoom camdolly camlookat camorbit campos camproj camroll camtarget camup camva camlight light lightangle lighting diffuse material specular alim alpha alphamap image imagesc imread imwrite imfinfo imformats frame2im im2frame im2java ind2rgb rgb2ind imapprox dither cmpermute cmunique print printopt printdlg printpreview hgexport saveas orient pagesetupdlg gca gcf gcbf gcbo gco ancestor allchild findall findfigs findobj ishandle copyobj delete get set propedit root figure axes image light line patch rectangle surface text annotation set get hggroup hgtransform makehgtform figure gcf close clf refresh newplot shg hgload hgsave saveas closereq dragrect drawnow rbbox opengl axes hold ishold newplot linkaxes linkprop refreshdata waitfor get set case otherwise else elseif edit input publish notebook grabcode snapnow script nargin nargout varargin varargout narginchk nargoutchk validateattributes validatestring inputParser inputname addRequired addOptional addParamValue parse createCopy nargchk persistent genvarname isvarname namelengthmax assignin global isglobal datatipinfo error warning lastwarn assert onCleanup lasterr lasterror dbclear dbcont dbdown dbquit dbstack dbstatus dbstep dbstop dbtype dbup checkcode keyboard mlintrpt mlint edit echo eval evalc evalin feval run builtin depdir depfun mfilename pcode timer delete disp get isvalid set start startat stop timerfind timerfindall wait clear clearvars disp load save openvar pack who whos workspace importdata load save matfile open winopen uiimport uigetfile uiputfile daqread csvread csvwrite dlmread dlmwrite fileread textread textscan type xlsfinfo xlsread xlswrite wk1finfo wk1read wk1write fclose feof ferror fgetl fgets fopen fprintf fread frewind fscanf fseek ftell fwrite exifread im2java imfinfo imread imwrite cdfepoch cdfinfo cdfread cdfwrite todatenum cdflib cdflib.getConstantNames cdflib.getConstantValue cdflib.getFileBackward cdflib.getLibraryCopyright cdflib.getLibraryVersion cdflib.getValidate cdflib.setFileBackward cdflib.setValidate cdflib.close cdflib.create cdflib.delete cdflib.getCacheSize cdflib.getChecksum cdflib.getCompression cdflib.getCompressionCacheSize cdflib.getCopyright cdflib.getFormat cdflib.getMajority cdflib.getName cdflib.getReadOnlyMode cdflib.getStageCacheSize cdflib.getVersion cdflib.inquire cdflib.open cdflib.setCacheSize cdflib.setChecksum cdflib.setCompression cdflib.setCompressionCacheSize cdflib.setFormat cdflib.setMajority cdflib.setReadOnlyMode cdflib.setStageCacheSize cdflib.closeVar cdflib.createVar cdflib.deleteVar cdflib.deleteVarRecords cdflib.getVarAllocRecords cdflib.getVarBlockingFactor cdflib.getVarCacheSize cdflib.getVarCompression cdflib.getVarData cdflib.getVarMaxAllocRecNum cdflib.getVarMaxWrittenRecNum cdflib.getVarName cdflib.getVarNum cdflib.getVarNumRecsWritten cdflib.getVarPadValue cdflib.getVarRecordData cdflib.getVarReservePercent cdflib.getVarsMaxWrittenRecNum cdflib.getVarSparseRecords cdflib.hyperGetVarData cdflib.hyperPutVarData cdflib.inquireVar cdflib.putVarData cdflib.putVarRecordData cdflib.renameVar cdflib.setVarAllocBlockRecords cdflib.setVarBlockingFactor cdflib.setVarCacheSize cdflib.setVarCompression cdflib.setVarInitialRecs cdflib.setVarPadValue cdflib.SetVarReservePercent cdflib.setVarsCacheSize cdflib.setVarSparseRecords cdflib.createAttr cdflib.deleteAttr cdflib.deleteAttrEntry cdflib.deleteAttrgEntry cdflib.getAttrEntry cdflib.getAttrgEntry cdflib.getAttrMaxEntry cdflib.getAttrMaxgEntry cdflib.getAttrName cdflib.getAttrNum cdflib.getAttrScope cdflib.getNumAttrEntries cdflib.getNumAttrgEntries cdflib.getNumAttributes cdflib.getNumgAttributes cdflib.inquireAttr cdflib.inquireAttrEntry cdflib.inquireAttrgEntry cdflib.putAttrEntry cdflib.putAttrgEntry cdflib.renameAttr cdflib.computeEpoch cdflib.computeEpoch16 cdflib.epoch16Breakdown cdflib.epochBreakdown nccreate ncdisp ncinfo ncread ncreadatt ncwrite ncwriteatt ncwriteschema netcdf netcdf.setChunkCache netcdf.getChunkCache netcdf.inqLibVers netcdf.setDefaultFormat netcdf.abort netcdf.close netcdf.create netcdf.endDef netcdf.inq netcdf.inqFormat netcdf.inqGrps netcdf.inqUnlimDims netcdf.open netcdf.reDef netcdf.setFill netcdf.sync netcdf.defDim netcdf.inqDim netcdf.inqDimID netcdf.renameDim netcdf.defGrp netcdf.inqDimIDs netcdf.inqGrpName netcdf.inqGrpNameFull netcdf.inqGrpParent netcdf.inqNcid netcdf.inqVarIDs netcdf.defVarFill netcdf.inqVarDeflate netcdf.defVar netcdf.defVarChunking netcdf.defVarDeflate netcdf.defVarFletcher32 netcdf.getVar netcdf.inqVar netcdf.inqVarChunking netcdf.inqVarFill netcdf.inqVarFletcher32 netcdf.inqVarID netcdf.putVar netcdf.renameVar netcdf.copyAtt netcdf.delAtt netcdf.getAtt netcdf.inqAtt netcdf.inqAttID netcdf.inqAttName netcdf.putAtt netcdf.renameAtt netcdf.getConstant netcdf.getConstantNames fitsdisp fitsinfo fitsread fitswrite h5create h5disp h5info h5read h5readatt h5write h5writeatt hdf hdf5 hdf5info hdf5read hdf5write hdfinfo hdfread hdftool multibandread multibandwrite audioinfo audioread audiowrite mmfileinfo movie2avi VideoReader VideoWriter aufinfo auread auwrite wavfinfo wavread wavwrite mmreader aviinfo avifile aviread addframe close audiodevinfo audioplayer audiorecorder sound soundsc get play playblocking set get getaudiodata play record recordblocking set wavplay wavrecord beep lin2mu mu2lin xmlread xmlwrite xslt disp get memmapfile cd copyfile delete dir fileattrib filebrowser isdir lookfor ls matlabroot mkdir movefile pwd recycle rmdir tempdir toolboxdir type visdiff what filemarker fileparts filesep fullfile tempdir tempname gunzip gzip tar untar unzip zip addpath genpath path path2rc pathsep pathtool restoredefaultpath rmpath savepath userpath which clipboard computer dos getenv hostid perl setenv system unix winqueryreg ftp sendmail urlread urlwrite web clear delete disp fclose fgetl fgets fopen fprintf fread fscanf fwrite get instrcallback instrfind instrfindall isvalid length load readasync record save serial serialbreak set size stopasync figure axes uicontrol uitable uipanel uibuttongroup actxcontrol guide inspect Uicontrol Uitable Uipanel Uibuttongroup uimenu uicontextmenu uitoolbar uipushtool uitoggletool Uimenu Uicontextmenu Uitoolbar Uipushtool Uitoggletool dialog errordlg helpdlg msgbox questdlg uigetpref uisetpref waitbar warndlg export2wsdlg inputdlg listdlg uisetcolor uisetfont printdlg printpreview uigetdir uigetfile uiopen uiputfile uisave menu align movegui getpixelposition setpixelposition listfonts textwrap uistack guidata guihandles openfig getappdata isappdata rmappdata setappdata uiresume uiwait waitfor waitforbuttonpress addpref getpref ispref rmpref setpref matlab.apputil.create matlab.apputil.package matlab.apputil.install matlab.apputil.run matlab.apputil.getInstalledAppInfo matlab.apputil.uninstall class isa isequal isobject enumeration events methods properties classdef import properties isprop methods ismethod delete findobj isa isvalid findprop relationaloperators events notify addlistener empty superclasses superiorto inferiorto enumeration save load saveobj loadobj cat horzcat vertcat empty disp display numel size end subsref subsasgn subsindex substruct metaclass meta.class.fromName meta.package.fromName meta.package.getAllPackages addCause getReport last rethrow throw throwAsCaller catch disp eq ne isequal bench cputime memory profile profsave tic toc clear inmem memory whos mislocked mlock munlock pack rehash builddocsearchdb javaArray javaclasspath javaaddpath javarmpath javaMethod javaMethodEDT javaObject javaObjectEDT javachk isjava usejava cell class clear depfun exist fieldnames im2java import inmem inspect isa methods methodsview which NET.addAssembly NET enableNETfromNetworkDrive NET.createArray cell NET.disableAutoRelease NET.enableAutoRelease NET.setStaticProperty BeginInvoke EndInvoke Combine Remove RemoveAll bitand bitor bitxor bitnot NET.convertArray NET.createGeneric NET.invokeGenericMethod actxserver actxcontrol actxcontrollist actxcontrolselect iscom isprop get set addproperty deleteproperty inspect propedit fieldnames ismethod methods methodsview invoke isevent events eventlisteners registerevent unregisterallevents unregisterevent isinterface interfaces release delete move load save Execute Feval GetCharArray PutCharArray GetFullMatrix PutFullMatrix GetVariable GetWorkspaceData PutWorkspaceData MaximizeCommandWindow MinimizeCommandWindow actxGetRunningServer enableservice Quit callSoapService createClassFromWsdl createSoapMessage parseSoapResponse loadlibrary calllib libfunctions libfunctionsview libisloaded unloadlibrary libstruct libpointer mex mex.getCompilerConfigurations mexext dbmex inmem checkin checkout cmopts customverctrl undocheckout verctrl matlab matlab exit quit matlabrc startup finish prefdir preferences ismac ispc isstudent isunix javachk license usejava ver verLessThan version doc help demo echodemo lookfor docsearch helpbrowser helpdesk helpwin info support whatsnew");
    var atoms = words("function return");

    var isOperatorChar = /[+\-*&%=<>!?|\/]/;

    function tokenBase(stream, state) {
        var ch = stream.next();
        if (ch == "#" && state.startOfLine) {
            stream.skipToEnd();
            return "meta";
        }
        if (ch == '"' || ch == "'") {
            state.tokenize = tokenString(ch);
            return state.tokenize(stream, state);
        }
        if (ch == "#" && stream.eat("{")) {
            state.tokenize = tokenComment;
            return tokenComment(stream, state);
        }
        if (ch == "%" && stream.eat("{")) {
            state.tokenize = tokenComment;
            return tokenComment(stream, state);
        }
        if (/[\[\]{}\(\),;\:\.]/.test(ch)) {
            return null;
        }
        if (/\d/.test(ch)) {
            stream.eatWhile(/[\w\.]/);
            return "number";
        }
        if (ch == "%") {
            stream.skipToEnd();
            return "comment";
        }
        if (isOperatorChar.test(ch)) {
            stream.eatWhile(isOperatorChar);
            return "operator";
        }
        stream.eatWhile(/[\w\$_]/);
        var cur = stream.current();
        if (keywords.propertyIsEnumerable(cur)) return "keyword";
        if (atoms.propertyIsEnumerable(cur)) return "atom";
        return "variable";
    }

    function tokenString(quote) {
        return function (stream, state) {
            var escaped = false, next, end = false;
            while ((next = stream.next()) != null) {
                if (next == quote && !escaped) { end = true; break; }
                escaped = !escaped && next == "\\";
            }
            if (end || !escaped) state.tokenize = null;
            return "string";
        };
    }

    function tokenComment(stream, state) {
        var maybeEnd = false, ch;
        while (ch = stream.next()) {
            if (ch == "}" && maybeEnd) {
                state.tokenize = null;
                break;
            }
            maybeEnd = (ch == "#" || ch == '%');
        }
        return "comment";
    }

    // Interface

    return {
        startState: function () {
            return { tokenize: null };
        },

        token: function (stream, state) {
            if (stream.eatSpace()) return null;
            var style = (state.tokenize || tokenBase)(stream, state);
            if (style == "comment" || style == "meta") return style;
            return style;
        },

        electricChars: "{}"
    };
});

CodeMirror.defineMIME("text/x-octave", "octave");
