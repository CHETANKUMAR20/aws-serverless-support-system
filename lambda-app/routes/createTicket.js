const { saveTicket } = require("../services/ticketService");
const { success, error } = require("../utils/response");

exports.createTicket = async (event) => {
    const body = JSON.parse(event.body || "{}");
    const { email, subject, description } = body;

    if (!email || !subject || !description) {
        return error(400, "Missing required fields");
    }

    const ticket = await saveTicket({ email, subject, description });

    return success(200, ticket);
};
