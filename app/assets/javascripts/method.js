
  function answer_form(user_name,comment_name,comment_id){

    let target = $(".posts_index-contents-contact");

    let html = `<h1>${comment_name} へ 返信</h1>
                <form action="/comments/${comment_id}/answers" accept-charset="UTF-8"  method="post">
                  <input name="utf8" type="hidden" value="✓">
                  <input value=${user_name} type="hidden" name="name">
                  <textarea placeholder="返信内容" rows="4" name="text" ></textarea>
                  <input type="submit" name="commit" value="送信" data-disable-with="送信">
                </form>`;

    target.empty();
    target.append(html);

  }