<#import "template.ftl" as layout>

<div class="flex h-screen font-Jakarta">
    <@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
        <#if section = "header">
            <div class="flex flex-col items-center justify-center">
                <img
                    class="h-10 w-40 mb-8"
                    src="${url.resourcesPath}/img/lavajato_logo.png"
                    alt="logo">
            </div>
            <div class="flex flex-col gap-4">
                <h1 class="text-xl font-semibold">
                    ${msg("emailForgotTitle")}
                </h1>
                <span class="text-sm font-normal text-gray-500 mb-4">
                    ${msg("emailResetPasswordMessage")}
                </span>
            </div>
        <#elseif section = "form">
            <form
                id="kc-reset-password-form"
                class="w-full mb-0"
                action="${url.loginAction}"
                method="post"
            >
                <div class="${properties.kcFormGroupClass!}">
                    <div class="">
                        <label
                            for="username"
                            class="text-sm font-medium w-full"
                        >
                            <#if !realm.loginWithEmailAllowed>${msg("username")}
                                <#elseif !realm.registrationEmailAsUsername>
                                    <#--  ${msg("usernameOrEmail")}
                                <#else>  -->
                                    ${msg("email")}
                            </#if>
                        </label>
                    </div>
                    <div class="">
                        <input
                            type="text"
                            id="username"
                            name="username"
                            class="rounded-md border border-gray-200 bg-white py-2 px-3 h-9 w-full"
                            autofocus
                            value="${(auth.attemptedUsername!'')}"
                            aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                        />
                        <#if messagesPerField.existsError('username')>
                            <span
                                id="input-error-username"
                                class="${properties.kcInputErrorMessageClass!}"
                                aria-live="polite"
                            >
                                ${msg("missingEmailMessage")}
                            </span>
                        </#if>
                    </div>
                </div>
                <div class="mb-0">
                    <div
                        id="kc-form-buttons"
                        class=""
                    >
                        <input
                            class="bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                            type="submit"
                            value="${msg("doSubmit")}"
                        />
                    <hr class="w-full border-t border-gray-200 mt-4 mb-4" />
                    </div>
                </div>
                    <div class="flex flex-col items-center justify-center w-full mt-4">
                        <a
                            tabindex="8"
                            class="no-underline hover:no-underline hover:text-black w-full bg-white rounded-md border border-gray-200 h-10 content-center text-center font-Jakarta text-sm font-medium"
                            href="${url.loginUrl}"
                        >
                            ${msg("backToLogin")}
                        </a>
                    </div>
            </form>
        <#elseif section = "info" >
            <#if realm.duplicateEmailsAllowed>
                ${msg("emailInstructionUsername")}
            <#else>
                ${msg("emailInstruction")}
            </#if>
        </#if>
    </@layout.registrationLayout>
</div>
