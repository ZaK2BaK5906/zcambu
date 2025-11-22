$(document).ready(function() {
    // Variables
    let currentLocation = null;
    let hasEasyItem = false;
    let hasHardItem = false;

    // Écouter les messages du client Lua
    window.addEventListener('message', function(event) {
        const data = event.data;

        switch(data.type) {
            case 'openUI':
                openUI(data);
                break;
        }
    });

    // Fonction pour ouvrir l'interface
    function openUI(data) {
        currentLocation = data.locationName;
        hasEasyItem = data.hasEasyItem;
        hasHardItem = data.hasHardItem;

        // Mettre à jour le nom de la location
        $('#locationName').text(data.locationName);

        // Mettre à jour les statuts et boutons
        updateOptionStatus('easy', hasEasyItem);
        updateOptionStatus('hard', hasHardItem);

        // Afficher l'interface avec animation
        $('#app').fadeIn(300);
    }

    // Fonction pour mettre à jour le statut d'une option
    function updateOptionStatus(type, hasItem) {
        const statusElement = $(`#${type}Status`);
        const btnElement = $(`#${type}Btn`);

        if (hasItem) {
            statusElement.removeClass('locked').addClass('available');
            statusElement.html(`
                <i class="fas fa-check-circle"></i>
                <span>Disponible</span>
            `);
            btnElement.prop('disabled', false);
        } else {
            statusElement.removeClass('available').addClass('locked');
            const itemName = type === 'easy' ? 'Crochet' : 'Crochet amélioré';
            statusElement.html(`
                <i class="fas fa-lock"></i>
                <span>${itemName} requis</span>
            `);
            btnElement.prop('disabled', true);
        }
    }

    // Fonction pour fermer l'interface
    function closeUI() {
        $('#app').fadeOut(300);

        // Envoyer un message au client Lua
        $.post('http://zcambu/closeUI', JSON.stringify({}));
    }

    // Fonction pour démarrer un braquage
    function startRobbery(type) {
        // Animation du bouton
        const btn = $(`#${type}Btn`);
        btn.html('<i class="fas fa-spinner fa-spin"></i><span>Démarrage...</span>');
        btn.prop('disabled', true);

        // Envoyer au client Lua
        $.post('http://zcambu/startRobbery', JSON.stringify({
            type: type
        }));

        // Fermer l'interface après un court délai
        setTimeout(() => {
            closeUI();
        }, 500);
    }

    // Events handlers
    $('#closeBtn').click(function() {
        closeUI();
    });

    $('#easyBtn').click(function() {
        if (!$(this).prop('disabled')) {
            startRobbery('easy');
        }
    });

    $('#hardBtn').click(function() {
        if (!$(this).prop('disabled')) {
            startRobbery('hard');
        }
    });

    // Fermer avec ESC
    $(document).keyup(function(e) {
        if (e.key === "Escape") {
            if ($('#app').is(':visible')) {
                closeUI();
            }
        }
    });

    // Effet hover sur les cartes
    $('.option-card').hover(
        function() {
            $(this).addClass('hover-effect');
        },
        function() {
            $(this).removeClass('hover-effect');
        }
    );

    // Animation des icônes au survol
    $('.option-icon').hover(
        function() {
            $(this).find('i').css('transform', 'rotate(360deg) scale(1.1)');
        },
        function() {
            $(this).find('i').css('transform', 'rotate(0deg) scale(1)');
        }
    );

    $('.option-icon i').css('transition', 'transform 0.5s ease');
});
