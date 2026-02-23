const { fetchTicket } = require("../services/ticketService");
const { success, error } = require("../utils/response");

exports.getTicket = async (event) => {

    if (!event.pathParameters || !event.pathParameters.id) {
        return error(400, "Missing ticket id");
    }

    const ticket_id = event.pathParameters.id;

    const ticket = await fetchTicket(ticket_id);

    if (!ticket) {
        return error(404, "Ticket Not Found");
    }

    return success(200, ticket);
};
