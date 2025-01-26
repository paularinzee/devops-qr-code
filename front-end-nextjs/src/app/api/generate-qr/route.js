// import { NextResponse } from "next/server";
// import axios from "axios";

// export async function POST(request) {
//     const { searchParams } = new URL(request.url);
//     const url = searchParams.get("url");

//     if (!url) {
//         return NextResponse.json({ error: "URL is required" }, { status: 400 });
//     }

//     try {
//         const response = await axios.post(`http://34.118.238.136:8000/generate-qr/?url=${encodeURIComponent(url)}`);
//         return NextResponse.json(response.data);
//     } catch (error) {
//         console.error("Error generating QR Code:", error);
//         return NextResponse.json({ error: "Error generating QR Code" }, { status: 500 });
//     }
// }