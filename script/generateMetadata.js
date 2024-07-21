const fs = require("fs");
const path = require("path");
//https://ipfs.io/ipfs/QmXLsjC6fi3m9uAQVayyXeXYf3YS336YWHjZ1bz1pY2pL9/
function generateMetadata() {
  const names = [
    "Alice Smith",
    "Bob Johnson",
    "Carol White",
    "David Brown",
    "Eve Green",
  ];
  const fieldsOfStudy = [
    "Computer Science",
    "Electrical Engineering",
    "Mechanical Engineering",
    "Civil Engineering",
    "Chemical Engineering",
  ];
  const graduationYears = [2020, 2021, 2022, 2023, 2024];
  const distinctions = [
    "Summa Cum Laude",
    "Magna Cum Laude",
    "Cum Laude",
    "Dean's List",
    "Honors",
  ];

  let imageURL = "QmXLsjC6fi3m9uAQVayyXeXYf3YS336YWHjZ1bz1pY2pL9"
  let nftCollection = [];

  for (let i = 0; i < 5; i++) {
    let nftMetadata = {
      name: `UTCN Faculty Diploma #${String(i + 1).padStart(3, "0")}`,
      description: `This NFT represents the official diploma of ${names[i]} from the Technical University of Cluj-Napoca.`,
      image: `ipfs:/${imageURL}/${i+1}.jpg`,
      attributes: [
        {
          trait_type: "Faculty Member",
          value: names[i],
        },
        {
          trait_type: "Degree",
          value: "Bachelor of Science",
        },
        {
          trait_type: "Field of Study",
          value: fieldsOfStudy[i],
        },
        {
          trait_type: "Graduation Year",
          value: graduationYears[i],
        },
        {
          trait_type: "University",
          value: "Technical University of Cluj-Napoca",
        },
        {
          trait_type: "Distinction",
          value: distinctions[i],
        },
        {
          trait_type: "ID",
          value: `#${String(i + 1).padStart(3, "0")}`,
        },
      ],
    };
    nftCollection.push(nftMetadata);
  }

  const dir = path.join(__dirname, "metadata");
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir);
  }

  nftCollection.forEach((metadata, index) => {
    const filePath = path.join(dir, `${index + 1}.json`);
    fs.writeFileSync(filePath, JSON.stringify(metadata, null, 2), "utf8");
  });

  console.log(
    'Metadata JSON files have been created in the "metadata" folder.'
  );
}

generateMetadata();
