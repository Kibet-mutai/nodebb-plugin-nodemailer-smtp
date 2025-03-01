"use strict";

import winston from "winston";
import Meta from "../../src/meta.js";
import nodemailer from "nodemailer";

let settings = {};

const NodemailerSMTP = {
  async init(data, callback) {
    function renderAdminPage(req, res) {
      res.render("admin/smtp", {});
    }

    data.router.get(
      "/admin/nodemailer/smtp",
      data.middleware.admin.buildHeader,
      renderAdminPage,
    );
    data.router.get("/api/admin/nodemailer/smtp", renderAdminPage);

    try {
      settings = await new Promise((resolve, reject) => {
        Meta.settings.get("nodemailer-smtp", (err, _settings) => {
          if (err) {
            reject(err);
          } else {
            resolve(_settings);
          }
        });
      });
    } catch (err) {
      winston.error("[nodemailer.smtp] Failed to load settings:", err);
    }

    callback();
  },

  async send(data, callback) {
    const smtpConfig = {
      host: settings["nodemailer:smtp:host"],
      port: parseInt(settings["nodemailer:smtp:port"], 10) || 587,
      secure: settings["nodemailer:smtp:secure"] === "true",
      requireTLS: settings["nodemailer:smtp:tls"] === "true",
      auth: {
        user: settings["nodemailer:smtp:username"],
        pass: settings["nodemailer:smtp:password"],
      },
    };

    const mailOptions = {
      from: {
        name: data.from_name,
        address: data.from,
      },
      to: {
        name: data._raw?.username || "User",
        address: data.to,
      },
      subject: data.subject,
      text: data.plaintext,
      html: data.html,
    };

    const transporter = nodemailer.createTransport(smtpConfig);

    try {
      await transporter.sendMail(mailOptions);
      winston.info(
        `[nodemailer.smtp] Sent '${data.template}' email to UID ${data.uid}`,
      );
      callback(null, data);
    } catch (err) {
      winston.error("[nodemailer.smtp] Email sending failed:", err);
      callback(err, data);
    }
  },

  admin: {
    menu(header, callback) {
      header.plugins.push({
        route: "/nodemailer/smtp",
        icon: "fa-envelope-o",
        name: "Nodemailer SMTP",
      });
      callback(null, header);
    },
  },
};

export default NodemailerSMTP;

