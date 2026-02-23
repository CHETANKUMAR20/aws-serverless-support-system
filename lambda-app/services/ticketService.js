const AWS = require("aws-sdk");
const dynamo = new AWS.DynamoDB.DocumentClient();

const TABLE_NAME = process.env.TABLE_NAME;

exports.saveTicket = async ({ email, subject, description }) => {

    const ticket_id = "TICK-" + Date.now();

    const item = {
        ticket_id,
        email,
        subject,
        description,
        status: "OPEN",
        created_at: new Date().toISOString()
    };

    await dynamo.put({
        TableName: TABLE_NAME,
        Item: item
    }).promise();

    return {
        message: "Ticket Created Successfully",
        ticket_id
    };
};

exports.fetchTicket = async (ticket_id) => {

    const result = await dynamo.get({
        TableName: TABLE_NAME,
        Key: { ticket_id }
    }).promise();

    return result.Item;
};
