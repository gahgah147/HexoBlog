<!--google_adsense-->
{% if theme.google_adsense.siderbar_enable %}
  <div class="links-of-blogroll-title">
    <i class="fa fa-google"></i> AdSense
    <ins class="adsbygoogle"
        style="display:block"
        data-ad-client="{{ theme.google_adsense.google_ad_client_id }}"
        data-ad-slot="{{ theme.google_adsense.siderbar_data_ad_slot }}"
        data-ad-format="auto"
        data-full-width-responsive="true"></ins>
    <script>
      (adsbygoogle = window.adsbygoogle || []).push({});
    </script>
  </div>
{% endif %}
<!--/google_adsense-->