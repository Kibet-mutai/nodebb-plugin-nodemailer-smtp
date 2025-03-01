<h1><i class="fa fa-envelope"></i> Nodemailer SMTP</h1>

<div class="row">
  <div class="col-lg-12">
    <blockquote class="blockquote">
      Plugin for NodeBB allowing you to send e-mail via SMTP using <b>LATEST</b> Nodemailer.
    </blockquote>
  </div>
</div>

<hr />

<form role="form" class="nodemailer-smtp-settings">
  <fieldset>
    <div class="row g-3">
      <div class="col-md-6">
        <div class="form-group">
          <label for="nodemailer:smtp:host" class="form-label">SMTP Host</label>
          <input type="text" class="form-control" id="nodemailer:smtp:host" name="nodemailer:smtp:host" required />
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label for="nodemailer:smtp:port" class="form-label">SMTP Port</label>
          <input type="number" class="form-control" value="25" id="nodemailer:smtp:port" name="nodemailer:smtp:port" required />
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label for="nodemailer:smtp:username" class="form-label">Username</label>
          <input type="text" class="form-control" id="nodemailer:smtp:username" name="nodemailer:smtp:username" required />
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label for="nodemailer:smtp:password" class="form-label">Password</label>
          <input type="password" class="form-control" id="nodemailer:smtp:password" name="nodemailer:smtp:password" autocomplete="off" required />
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="nodemailer:smtp:secure" name="nodemailer:smtp:secure">
          <label class="form-check-label" for="nodemailer:smtp:secure">
            Enable Secure Connection
          </label>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="nodemailer:smtp:tls" name="nodemailer:smtp:tls">
          <label class="form-check-label" for="nodemailer:smtp:tls">
            Enable TLS Connection
          </label>
        </div>
      </div>
    </div>

    <button type="button" class="btn btn-lg btn-primary mt-3" id="save">Save</button>
  </fieldset>
</form>

<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function () {
    require(["settings"], function (Settings) {
      Settings.load("nodemailer-smtp", $(".nodemailer-smtp-settings"));

      $("#save").on("click", function () {
        Settings.save("nodemailer-smtp", $(".nodemailer-smtp-settings"), function () {
          app.alert({
            alert_id: "nodemailer-smtp",
            type: "success",
            title: "Settings Updated",
            message: "Please restart NodeBB to apply these changes.",
            timeout: 5000,
            clickfn: function () {
              socket.emit("admin.reload");
            },
          });
        });
      });
    });
  });
</script>

