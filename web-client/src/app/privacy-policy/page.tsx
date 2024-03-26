import React from "react";

export default function Page() {
  return (
    <section className="py-3" id="terms">
      <h1 className="headline font-weight-bold text-center my-12">
        プライバシーポリシー
      </h1>
      <div className="contents-wrapper">
        {/* お客様から取得する情報 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">
            お客様から取得する情報
          </h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社は、お客様から以下の情報を取得します。
            </div>
          </div>
          <div style={{ marginLeft: "30px" }}>
            <ul className="pl-4">
              <li className="py-1">氏名(ニックネームやペンネームも含む)</li>
              <li className="py-1">性別</li>
              <li className="py-1">メールアドレス</li>
              <li className="py-1">写真や動画</li>
              <li className="py-1">
                クレジットカード、銀行口座、電子マネー等のお客様の決済手段に関する情報
              </li>
              <li className="py-1">
                外部サービスでお客様が利用するID、その他外部サービスのプライバシー設定によりお客様が連携先に開示を認めた情報
              </li>
              <li className="py-1">
                Cookie(クッキー)を用いて生成された識別情報
              </li>
              <li className="py-1">
                OSが生成するID、端末の種類、端末識別子等のお客様が利用するOSや端末に関する情報
              </li>
              <li className="py-1">
                当社ウェブサイトの滞在時間、入力履歴、購買履歴等の当社ウェブサイトにおけるお客様の行動履歴
              </li>
              <li className="py-1">
                当社アプリの起動時間、入力履歴、購買履歴等の当社アプリの利用履歴
              </li>
              <li className="py-1">お客様の位置情報</li>
              <li className="py-1">歩数や犬の状態などのヘルス情報</li>
            </ul>
          </div>
        </div>

        {/* お客様の情報を利用する目的 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">
            お客様の情報を利用する目的
          </h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社は、お客様から取得した情報を、以下の目的のために利用します。
            </div>
          </div>
          <div style={{ marginLeft: "30px" }}>
            <ul className="pl-4">
              <li className="py-1">
                当社サービスに関する登録の受付、お客様の本人確認、認証のため
              </li>
              <li className="py-1">
                お客様の当社サービスの利用履歴を管理するため
              </li>
              <li className="py-1">利用料金の決済のため</li>
              <li className="py-1">
                当社サービスにおけるお客様の行動履歴を分析し、当社サービスの維持改善に役立てるため
              </li>
              <li className="py-1">広告の配信、表示及び効果測定のため</li>
              <li className="py-1">
                お客様の趣味嗜好にあわせたターゲティング広告を表示するため
              </li>
              <li className="py-1">当社のサービスに関するご案内をするため</li>
              <li className="py-1">
                提携する事業者・サービスのご案内をお送りするため
              </li>
              <li className="py-1">お客様からのお問い合わせに対応するため</li>
              <li className="py-1">
                当社の規約や法令に違反する行為に対応するため
              </li>
              <li className="py-1">
                当社サービスの変更、提供中止、終了、契約解除をご連絡するため
              </li>
              <li className="py-1">当社規約の変更等を通知するため</li>
              <li className="py-1">
                以上の他、当社サービスの提供、維持、保護及び改善のため
              </li>
            </ul>
          </div>
        </div>

        {/* 安全管理のために講じた措置 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">
            安全管理のために講じた措置
          </h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社が、お客様から取得した情報に関して安全管理のために講じた措置につきましては、末尾記載のお問い合わせ先にご連絡をいただきましたら、法令の定めに従い個別にご回答させていただきます。
            </div>
          </div>
        </div>

        {/* 第三者提供 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">第三者提供</h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社は、お客様から取得する情報のうち、個人データ（個人情報保護法第１６条第３項）に該当するものついては、あらかじめお客様の同意を得ずに、第三者（日本国外にある者を含みます。）に提供しません。但し、次の場合は除きます。
            </div>
          </div>
          <div style={{ marginLeft: "14px" }}>
            <ul className="pl-4">
              <li className="py-1">個人データの取扱いを外部に委託する場合</li>
              <li className="py-1">当社や当社サービスが買収された場合</li>
              <li className="py-1">
                事業パートナーと共同利用する場合（具体的な共同利用がある場合は、その内容を別途公表します。）
              </li>
              <li className="py-1">
                その他、法律によって合法的に第三者提供が許されている場合
              </li>
            </ul>
          </div>
        </div>

        {/* アクセス解析ツール */}
        <div>
          <h2 className="font-weight-bold subtitle-1">アクセス解析ツール</h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社は、お客様のアクセス解析のために、「Googleアナリティクス」を利用しています。Googleアナリティクスは、トラフィックデータの収集のためにCookieを使用しています。トラフィックデータは匿名で収集されており、個人を特定するものではありません。Cookieを無効にすれば、これらの情報の収集を拒否することができます。詳しくはお使いのブラウザの設定をご確認ください。Googleアナリティクスについて、詳しくは以下からご確認ください。
              <a href="https://marketingplatform.google.com/about/analytics/terms/jp/">
                https://marketingplatform.google.com/about/analytics/terms/jp/
              </a>
            </div>
          </div>
        </div>

        {/* 広告の配信 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">広告の配信</h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社は、Google及びそのパートナー（第三者配信事業者）の提供する広告を設置しています。広告配信にはCookieを使用し、お客様が過去に当社ウェブサイトやその他のサイトにアクセスした情報に基づいて広告を配信します。Google
              やそのパートナーは、Cookieを使用することにより適切な広告を表示しています。
              お客様は、以下のGoogleアカウントの広告設定ページから、パーソナライズ広告を無効にできます。
              <a href="https://adssettings.google.com/u/0/authenticated">
                https://adssettings.google.com/u/0/authenticated
              </a>
              また aboutads.info
              のページにアクセスし、パーソナライズ広告掲載に使用される第三者配信事業者のCookieを無効にすることもできます。
              その他、GoogleによるCookieの取り扱い詳細については、以下のGoogleのポリシーと規約のページをご覧ください。
              <a href="https://policies.google.com/technologies/ads">
                https://policies.google.com/technologies/ads
              </a>
            </div>
          </div>
        </div>

        {/* プライバシーポリシーの変更 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">
            プライバシーポリシーの変更
          </h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              当社は、必要に応じて、このプライバシーポリシーの内容を変更します。この場合、変更後のプライバシーポリシーの施行時期と内容を適切な方法により周知または通知します。
            </div>
          </div>
        </div>

        {/* お問い合わせ */}
        <div>
          <h2 className="font-weight-bold subtitle-1">お問い合わせ</h2>
          <div style={{ marginLeft: "14px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              お客様の情報の開示、情報の訂正、利用停止、削除をご希望の場合は、以下のメールアドレスにご連絡ください。
              <a href="mailto:withbichon@gmail.com">withbichon@gmail.com</a>
            </div>
          </div>
        </div>

        {/* 事業者の氏名 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">事業者の氏名</h2>
          <div style={{ marginLeft: "20px" }}>
            <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
              Subaru Nakano
            </div>
          </div>
        </div>

        {/* 事業者の住所 */}
        <div>
          <h2 className="font-weight-bold subtitle-1">事業者の住所</h2>
          東京都
        </div>
      </div>
      <div className="word-wrap mb-2" style={{ whiteSpace: "pre-wrap" }}>
        2024年02月21日 制定
      </div>
    </section>
  );
}
