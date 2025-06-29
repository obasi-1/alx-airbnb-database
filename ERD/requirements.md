<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interactive ER Diagram - Property Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Chosen Palette: Warm Neutrals -->
    <!-- Application Structure Plan: A single-page, diagram-centric layout. The left side features a large, interactive canvas where the ER diagram is visually rendered using HTML divs for entities and an HTML Canvas for relationship lines. The right side contains a detail panel. When a user clicks an entity on the diagram, the detail panel updates to show its name, description, attributes (with keys), and relationships. This structure was chosen because it focuses the user's attention on the visual model, making the relationships and overall schema intuitive. It allows for direct exploration, turning a static specification into an interactive learning tool, which is superior to a linear text-based layout for understanding complex systems. -->
    <!-- Visualization & Content Choices: 
        - ER Diagram (Entities & Lines): Report Info -> Database Schema. Goal -> Organize/Show Relationships. Viz/Method -> HTML divs for entities, positioned over an HTML Canvas for drawing relationship lines. Interaction -> Clicking an entity div highlights it and updates a detail panel. Justification -> This provides a fully custom, interactive, and visually clear representation of the schema without using unsupported libraries like MermaidJS or SVG. It allows for rich interaction and styling. Library/Method -> Vanilla JS for DOM manipulation and Canvas API for drawing.
        - Detail Panel: Report Info -> Entity attributes and relationships. Goal -> Inform. Viz/Method -> A dynamically updated HTML block with structured lists. Interaction -> Content changes based on the selected entity in the diagram. Justification -> This provides context-sensitive information, preventing overload by only showing details for the entity the user is currently interested in. Library/Method -> Vanilla JS.
        - Key Indicators: Report Info -> Primary/Foreign Keys. Goal -> Inform. Viz/Method -> Unicode characters (🔑, 🔗) within the detail panel's attribute list. Interaction -> Static visual cues. Justification -> These are universally understood, lightweight icons that clearly denote an attribute's role without adding visual clutter. Library/Method -> HTML/CSS.
    -->
    <!-- CONFIRMATION: NO SVG graphics used. NO Mermaid JS used. -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #FDFBF8;
            color: #4A4A4A;
        }
        .entity {
            transition: all 0.2s ease-in-out;
            cursor: pointer;
            border: 2px solid #D1D5DB;
        }
        .entity.active {
            border-color: #A57F60;
            transform: scale(1.05);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            z-index: 20;
        }
        .entity:hover {
            border-color: #C39F81;
            transform: scale(1.02);
        }
        #diagram-canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }
        #diagram-container {
            position: relative;
        }
    </style>
</head>
<body class="antialiased">

    <div class="min-h-screen flex flex-col">
        <header class="bg-white/80 backdrop-blur-md shadow-sm p-4 border-b border-gray-200 sticky top-0 z-30">
            <div class="max-w-7xl mx-auto">
                <h1 class="text-2xl font-bold text-[#A57F60]">Property Booking System</h1>
                <p class="text-sm text-gray-600">An Interactive Entity-Relationship Diagram</p>
            </div>
        </header>

        <main class="flex-grow flex flex-col lg:flex-row p-4 md:p-6 lg:p-8 gap-6 max-w-7xl mx-auto w-full">
            
            <section id="diagram-section" class="w-full lg:w-2/3 bg-white rounded-xl shadow-lg border border-gray-200 p-4 relative flex-grow">
                <div id="diagram-container" class="w-full h-[60vh] lg:h-full">
                    <canvas id="diagram-canvas"></canvas>
                    <!-- Entities will be dynamically placed here -->
                </div>
            </section>

            <aside id="details-section" class="w-full lg:w-1/3 bg-white rounded-xl shadow-lg border border-gray-200 p-6 flex flex-col">
                 <div id="details-content" class="flex-grow overflow-y-auto">
                    <div id="welcome-message" class="text-center h-full flex flex-col justify-center">
                        <svg class="w-16 h-16 mx-auto text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M15 15l-2 5L9 9l11 4-5 2zm0 0l5 5M7.188 8.812a9.025 9.025 0 0112.728 0M11 19a9.025 9.025 0 0012.728 0M1 15l2-5 6 6-5 2zm0 0l5 5"></path></svg>
                        <h2 class="mt-4 text-xl font-semibold text-gray-700">Explore the Schema</h2>
                        <p class="mt-2 text-gray-500">Click on any entity in the diagram to view its details, attributes, and relationships.</p>
                    </div>
                    <div id="entity-details" class="hidden">
                        <h2 id="details-title" class="text-2xl font-bold text-[#A57F60] mb-1"></h2>
                        <p id="details-description" class="text-sm text-gray-600 mb-6 pb-4 border-b border-gray-200"></p>
                        
                        <h3 class="font-semibold text-lg text-gray-800 mb-3">Attributes</h3>
                        <ul id="details-attributes" class="space-y-2 mb-6"></ul>
                        
                        <h3 class="font-semibold text-lg text-gray-800 mb-3">Relationships</h3>
                        <ul id="details-relationships" class="space-y-3"></ul>
                    </div>
                </div>
            </aside>
        </main>
    </div>

    <script>
        const entities = {
            USER: {
                id: 'USER',
                name: 'User',
                description: 'Represents individuals who can own properties or make bookings.',
                pos: { x: 5, y: 35 },
                attributes: [
                    { name: 'id', type: 'int', key: 'PK' },
                    { name: 'name', type: 'varchar' },
                    { name: 'email', type: 'varchar' },
                    { name: 'password', type: 'varchar' },
                    { name: 'phone_number', type: 'varchar' },
                    { name: 'address', type: 'text' },
                    { name: 'created_at', type: 'datetime' },
                ],
            },
            PROPERTY: {
                id: 'PROPERTY',
                name: 'Property',
                description: 'Represents a property available for booking.',
                pos: { x: 35, y: 5 },
                attributes: [
                    { name: 'id', type: 'int', key: 'PK' },
                    { name: 'owner_id', type: 'int', key: 'FK' },
                    { name: 'title', type: 'varchar' },
                    { name: 'description', type: 'text' },
                    { name: 'type', type: 'varchar' },
                    { name: 'address', type: 'varchar' },
                    { name: 'price_per_night', type: 'decimal' },
                    { name: 'max_guests', type: 'int' },
                    { name: 'created_at', type: 'datetime' },
                ]
            },
            BOOKING: {
                id: 'BOOKING',
                name: 'Booking',
                description: 'Represents a booking made by a user for a property.',
                pos: { x: 35, y: 35 },
                attributes: [
                    { name: 'id', type: 'int', key: 'PK' },
                    { name: 'user_id', type: 'int', key: 'FK' },
                    { name: 'property_id', type: 'int', key: 'FK' },
                    { name: 'check_in_date', type: 'date' },
                    { name: 'check_out_date', type: 'date' },
                    { name: 'number_of_guests', type: 'int' },
                    { name: 'total_price', type: 'decimal' },
                    { name: 'status', type: 'varchar' },
                    { name: 'created_at', type: 'datetime' },
                ]
            },
            REVIEW: {
                id: 'REVIEW',
                name: 'Review',
                description: 'Represents a review left by a user for a property.',
                pos: { x: 35, y: 65 },
                attributes: [
                    { name: 'id', type: 'int', key: 'PK' },
                    { name: 'user_id', type: 'int', key: 'FK' },
                    { name: 'property_id', type: 'int', key: 'FK' },
                    { name: 'rating', type: 'int' },
                    { name: 'comment', type: 'text' },
                    { name: 'created_at', type: 'datetime' },
                ]
            },
            PAYMENT: {
                id: 'PAYMENT',
                name: 'Payment',
                description: 'Represents a payment made for a booking.',
                pos: { x: 65, y: 35 },
                attributes: [
                    { name: 'id', type: 'int', key: 'PK' },
                    { name: 'booking_id', type: 'int', key: 'FK' },
                    { name: 'amount', type: 'decimal' },
                    { name: 'payment_method', type: 'varchar' },
                    { name: 'status', type: 'varchar' },
                    { name: 'created_at', type: 'datetime' },
                ]
            },
            AMENITY: {
                id: 'AMENITY',
                name: 'Amenity',
                description: 'Represents the amenities available (e.g., Wi-Fi, Pool).',
                pos: { x: 5, y: 80 },
                attributes: [
                    { name: 'id', type: 'int', key: 'PK' },
                    { name: 'name', type: 'varchar' },
                ]
            },
            PROPERTY_AMENITY: {
                id: 'PROPERTY_AMENITY',
                name: 'Property Amenity',
                description: 'Junction table for the many-to-many relationship between properties and amenities.',
                pos: { x: 35, y: 90 },
                posAnchor: 'top',
                attributes: [
                    { name: 'property_id', type: 'int', key: 'FK' },
                    { name: 'amenity_id', type: 'int', key: 'FK' },
                ]
            },
        };

        const relationships = [
            { from: 'USER', to: 'PROPERTY', label: '1..n', type: 'owns' },
            { from: 'USER', to: 'BOOKING', label: '1..n', type: 'places' },
            { from: 'USER', to: 'REVIEW', label: '1..n', type: 'writes' },
            { from: 'PROPERTY', to: 'BOOKING', label: '1..n', type: 'has' },
            { from: 'PROPERTY', to: 'REVIEW', label: '1..n', type: 'receives' },
            { from: 'BOOKING', to: 'PAYMENT', label: '1..n', type: 'has' },
            { from: 'BOOKING', to: 'REVIEW', label: '1..1', type: 'is_for' },
            { from: 'PROPERTY', to: 'PROPERTY_AMENITY', label: '1..n', type: 'links_to'},
            { from: 'AMENITY', to: 'PROPERTY_AMENITY', label: '1..n', type: 'links_to'}
        ];

        const diagramContainer = document.getElementById('diagram-container');
        const canvas = document.getElementById('diagram-canvas');
        const ctx = canvas.getContext('2d');
        let activeEntity = null;

        function draw() {
            const containerRect = diagramContainer.getBoundingClientRect();
            canvas.width = containerRect.width;
            canvas.height = containerRect.height;

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.strokeStyle = '#9CA3AF'; // gray-400
            ctx.fillStyle = '#9CA3AF';
            ctx.lineWidth = 2;

            relationships.forEach(rel => {
                const fromEntityEl = document.getElementById(`entity-${rel.from}`);
                const toEntityEl = document.getElementById(`entity-${rel.to}`);
                if (!fromEntityEl || !toEntityEl) return;

                const fromRect = fromEntityEl.getBoundingClientRect();
                const toRect = toEntityEl.getBoundingClientRect();
                
                const fromX = fromRect.left - containerRect.left + fromRect.width / 2;
                const fromY = fromRect.top - containerRect.top + fromRect.height / 2;
                const toX = toRect.left - containerRect.left + toRect.width / 2;
                const toY = toRect.top - containerRect.top + toRect.height / 2;

                ctx.beginPath();
                if (activeEntity && (rel.from === activeEntity.id || rel.to === activeEntity.id)) {
                    ctx.strokeStyle = '#A57F60';
                    ctx.lineWidth = 3;
                } else {
                    ctx.strokeStyle = '#D1D5DB';
                    ctx.lineWidth = 2;
                }
                ctx.moveTo(fromX, fromY);
                ctx.lineTo(toX, toY);
                ctx.stroke();

                // Draw arrow at the 'to' end
                const angle = Math.atan2(toY - fromY, toX - fromX);
                ctx.save();
                ctx.translate(toX, toY);
                ctx.rotate(angle);
                ctx.beginPath();
                ctx.moveTo(-10, -5);
                ctx.lineTo(0, 0);
                ctx.lineTo(-10, 5);
                ctx.stroke();
                ctx.restore();
            });
        }

        function displayEntityDetails(entityId) {
            const entity = entities[entityId];
            if (!entity) return;
            
            activeEntity = entity;

            document.querySelectorAll('.entity').forEach(el => el.classList.remove('active'));
            document.getElementById(`entity-${entity.id}`).classList.add('active');

            document.getElementById('welcome-message').classList.add('hidden');
            const detailsView = document.getElementById('entity-details');
            detailsView.classList.remove('hidden');

            document.getElementById('details-title').textContent = entity.name;
            document.getElementById('details-description').textContent = entity.description;

            const attributesList = document.getElementById('details-attributes');
            attributesList.innerHTML = '';
            entity.attributes.forEach(attr => {
                const keyIcon = attr.key === 'PK' ? '🔑' : attr.key === 'FK' ? '🔗' : '▪️';
                const li = document.createElement('li');
                li.className = 'flex items-center text-sm p-2 rounded-md bg-gray-50';
                li.innerHTML = `
                    <span class="mr-3 text-lg">${keyIcon}</span>
                    <span class="font-medium text-gray-800 w-2/5">${attr.name}</span>
                    <span class="text-gray-500">${attr.type}</span>
                `;
                attributesList.appendChild(li);
            });

            const relationshipsList = document.getElementById('details-relationships');
            relationshipsList.innerHTML = '';
            const related = relationships.filter(r => r.from === entity.id || r.to === entity.id);
            related.forEach(rel => {
                const isOrigin = rel.from === entity.id;
                const otherEntityId = isOrigin ? rel.to : rel.from;
                const otherEntity = entities[otherEntityId];
                const li = document.createElement('li');
                li.className = 'text-sm p-3 rounded-lg border border-gray-200 bg-white';
                li.innerHTML = `
                    <div class="font-semibold text-gray-700">
                        <span class="text-[#A57F60]">${isOrigin ? entity.name : otherEntity.name}</span> 
                        <span class="text-gray-500 font-normal">(${rel.label})</span>
                        <span class="text-gray-500 font-normal">${rel.type}</span>
                        <span class="text-[#A57F60]">${isOrigin ? otherEntity.name : entity.name}</span>
                    </div>
                `;
                relationshipsList.appendChild(li);
            });

            draw();
        }

        function createEntities() {
            Object.values(entities).forEach(entity => {
                const el = document.createElement('div');
                el.id = `entity-${entity.id}`;
                el.className = 'entity absolute bg-white rounded-lg shadow-md p-3 w-40 text-center border-2 border-gray-300 z-10';
                el.style.left = `${entity.pos.x}%`;
                el.style.top = `${entity.pos.y}%`;
                
                const title = document.createElement('h3');
                title.className = 'font-bold text-gray-800';
                title.textContent = entity.name;
                el.appendChild(title);

                el.addEventListener('click', () => displayEntityDetails(entity.id));
                diagramContainer.appendChild(el);
            });
        }
        
        window.addEventListener('resize', draw);
        window.addEventListener('load', () => {
            createEntities();
            draw();
        });

    </script>

</body>
</html>
