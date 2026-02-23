const { createTicket } = require("./routes/createTicket");
const { getTicket } = require("./routes/getTicket");

exports.handler = async (event) => {

    const method = event.requestContext.http.method;

    if (method === "POST") {
        return await createTicket(event);
    }

    if (method === "GET") {
        return await getTicket(event);
    }

    return {
        statusCode: 405,
        body: JSON.stringify({ message: "Method Not Allowed" })
    };
};
