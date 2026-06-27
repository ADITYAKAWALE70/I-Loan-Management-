const nodemailer =
  require("nodemailer");

const transporter =
  nodemailer.createTransport({

    service: "gmail",

    auth: {
      user: "tarlemayuri74@gmail.com",
      pass: "yiptgypbygyqxjns",
    },
  });

module.exports = transporter;