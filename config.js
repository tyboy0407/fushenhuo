// 共用資料庫設定（Supabase）
// 把 Supabase 專案的 Project URL 和 Publishable key 貼在下面的引號裡，
// 網站就會把大家填的內容存到雲端，所有人打開都看得到。
// 兩個都留空的話，內容只會存在各自裝置的瀏覽器裡。
//
// 這把 Publishable key 可以公開：資料庫有開 Row Level Security，
// 它只能讀寫 fushenhuo_docs 這一張表（見 supabase/schema.sql）。
window.SITE_CONFIG = {
  supabaseUrl: "",
  supabaseKey: ""
};
