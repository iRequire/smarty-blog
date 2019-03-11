{include file="include/header.tpl" title="Neuer Blogeintrag"  admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="text-center">Blogeintrag erstellen</h1>
            {include file="include/notifications.tpl" notifications=$data.notifications}

            <form id="createBlog" method="post" action="">
                <input type="hidden" name="addBlogPost" value="true">
                <input type="hidden" name="blog_text" id="blog_text">
                <h1 class="mt-4"><input type="text" class="form-control" name="blog_title" placeholder="Titel"></h1>
                <hr>
                <p class="lead">
                    <div id="editor" style="max-height: 400px;">

                    </div>
                </p>
                <input type="submit" class="btn btn-info" value="Absenden">
            </form>
        </div>
    </div>
</div>




{include file="include/footer.tpl" editor=true}