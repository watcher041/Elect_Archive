
// HTMLの読み込みを終了した後に実行
$(function(){
  
  // 画像がファイル選択された場合に起動
  $(".image-file").on("change",function(event){

    // イベントから画像のファイル情報を抜き出す
    let file = event.target.files[0];
    
    // FileReaderオブジェクトを作成します
    let reader = new FileReader();

    // DataURIScheme文字列を取得します
    reader.readAsDataURL(file);
    
    // 読み込みが完了したら処理が実行されます
    reader.onload = function () {
  
      // 読み込んだファイルの内容を取得して変数imageに代入します
      let image = this.result;

      // ラベルのノードを取得
      let label = $('.file-image').get(0);

      // 画像の差し替えを行う
      label.src = image;
    
    }

  })

 

})